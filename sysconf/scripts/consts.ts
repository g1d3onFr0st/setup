import path from "path";
import os from "os";

export const homeDir = os.homedir()
export const currentDir = path.join(
    homeDir,
    "setup",
    "sysconf"
)
export const scriptsDir = path.join(
    currentDir,
    "scripts"
)
