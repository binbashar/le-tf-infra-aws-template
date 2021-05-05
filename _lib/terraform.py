import os
import subprocess

from leverage import path
from leverage import conf

# Get build config variables
env = conf.load()

# Set project name
project = env.get("PROJECT", "")
if project == "": raise Exception("Project is not set")

# Enable MFA support?
mfa_enabled = env.get("MFA_ENABLED", "true").lower() == "true"

# Use TTY
use_tty = env.get("USE_TTY", "false").lower() == "true"

# Set default entrypoint, use the mfa entrypoint if mfa is enabled
docker_entrypoint = env.get("TERRAFORM_ENTRYPOINT", "/bin/terraform")
if mfa_enabled:
    docker_entrypoint = env.get("TERRAFORM_MFA_ENTRYPOINT", docker_entrypoint)

# Set docker image, workdir, and other default arguments
docker_image = f"{env.get("TERRAFORM_IMAGE_NAME")}:{env.get("TERRAFORM_IMAGE_TAG")}"
docker_workdir = "/go/src/project"
docker_cmd = [
    "docker",
    "run",
    "--security-opt=label:disable",
    "--rm",
    f"--workdir={docker_workdir}" 
]

# Instruct docker to use a TTY -- This might be useful when running this on
# an automation tool such as Jenkins which doesn't provide pseudo terminal
# by default
if use_tty:
    docker_cmd.append("--tty")
else:
    # Otherwise, by default, we assume the CLI is being run on a terminal
    docker_cmd.append("-it")

# Set docker volumes -- MFA uses additional volumes
docker_volumes = [
    f"--volume={path.get_working_path()}:{docker_workdir}:rw",
    f"--volume={path.get_account_config_path()}:/config",
    f"--volume={path.get_global_config_path()}:/common-config",
    f"--volume={path.get_home_path()}/.ssh:/root/.ssh",
    f"--volume={path.get_home_path()}/.gitconfig:/etc/gitconfig",
]
if mfa_enabled:
    # TODO: Re-implement the scripts in @bin as python
    docker_volumes.append(f"--volume={path.get_root_path()}/@bin/scripts:/root/scripts")
    docker_volumes.append(f"--volume={path.get_home_path()}/.aws/{project}:/root/tmp/{project}")
else:
    docker_volumes.append(f"--volume={path.get_home_path()}/.aws/{project}:/root/.aws/{project}")

# Set docker environment variables -- MFA uses additional environment variables
docker_envs = [
    f"--env=AWS_SHARED_CREDENTIALS_FILE=/root/.aws/{project}/credentials",
    f"--env=AWS_CONFIG_FILE=/root/.aws/{project}/config",
]
# TODO: Check the final names for config files
if mfa_enabled:
    docker_envs.append("--env=BACKEND_CONFIG_FILE=/config/backend.config")
    docker_envs.append("--env=COMMON_CONFIG_FILE=/common-config/common.config")
    docker_envs.append(f"--env=SRC_AWS_CONFIG_FILE=/root/tmp/{project}/config")
    docker_envs.append(f"--env=SRC_AWS_SHARED_CREDENTIALS_FILE=/root/tmp/{project}/credentials")
    docker_envs.append(f"--env=AWS_CACHE_DIR=/root/tmp/{project}/cache")
# Set Terraform default arguments -- normally used for plan, apply, destroy, and others
terraform_default_args = [
    "-var-file=/config/backend.config",
    "-var-file=/common-config/common.config",
    "-var-file=/config/account.config"
]

# -------------------------------------------------------------------

#
# Helper to build the docker commands.
#
def _build_cmd(command="", args=[], entrypoint=docker_entrypoint, extra_args=[]):
    # Start building the docker run command
    cmd = docker_cmd + docker_volumes + docker_envs

    # Set the default entrypoint
    cmd.append(f"--entrypoint={entrypoint}") 

    # Set the image to use
    cmd.append(docker_image)
    if command != "":
        # Since MFA mode runs a different entrypoint, we also need to specify
        # another binary to pass the execution to (in this case: helmsman)
        if mfa_enabled:
            cmd.append("--")
            cmd.append(env.get("TERRAFORM_ENTRYPOINT"))

        # After the entrypoint has been figured out, append the helmsman command to run
        cmd.append(command)

    # Append extra arguments if any were provided
    if extra_args:
        args = args + extra_args

    # Finally append all the arguments to the docker command
    cmd = cmd + args
    print(f"[DEBUG] {" ".join(cmd)}")
    return cmd

def init(extra_args):
    # TODO: Check the final names for config files
    cmd = _build_cmd(
        command="init",
        args=["-backend-config=/config/backend.config"],
        extra_args=extra_args
    )
    return subprocess.call(cmd)

def plan(extra_args):
    cmd = _build_cmd(command="plan", args=terraform_default_args, extra_args=extra_args)
    return subprocess.call(cmd)

def apply(extra_args):
    cmd = _build_cmd(command="apply", args=terraform_default_args, extra_args=extra_args)
    return subprocess.call(cmd)

def output():
    cmd = _build_cmd(command="output")
    return subprocess.call(cmd)

def destroy(extra_args):
    cmd = _build_cmd(command="destroy", args=terraform_default_args, extra_args=extra_args)
    return subprocess.call(cmd)

def version():
    cmd = _build_cmd(command="version")
    return subprocess.call(cmd)

def shell(extra_args):
    cmd = _build_cmd(command="", entrypoint="/bin/sh", extra_args=extra_args)
    return subprocess.call(cmd)

def format_check():
    # We don't need MFA for this command
    global mfa_enabled
    mfa_enabled = False
    cmd = _build_cmd(command="fmt", entrypoint="/bin/terraform", args=["-recursive", "-check", docker_workdir])
    return subprocess.call(cmd)

def format():
    # We don't need MFA for this command
    global mfa_enabled
    mfa_enabled = False
    cmd = _build_cmd(command="fmt", entrypoint="/bin/terraform", args=["-recursive"])
    return subprocess.call(cmd)

def change_terraform_dir_ownership():
    return os.system("sudo chown -R $(id -u):$(id -g) ./.terraform || true")