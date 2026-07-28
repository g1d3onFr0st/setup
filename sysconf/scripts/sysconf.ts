import { currentDir, homeDir, scriptsDir } from "./consts.ts"

const [_l1, _l2, command, ...rest] = process.argv

switch (command) {
    case "pkgs": {
        const [cat, command, ...pkgs] = rest
        if (!["nix", "local", "bloat"].includes(cat)) process.exit()
        console.log(`${cat} ${command} ${pkgs.join(" ")} `)
        process.exit()
    }
    case "hostname": {

    }
    default: {
        console.log("no such commad")
    }
}
