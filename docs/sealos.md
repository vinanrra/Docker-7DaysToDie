# Deploy on Sealos

The community-maintained Sealos template runs one private 7 Days to Die server using this project's Docker image, with persistent saves and public TCP/UDP game ports.

## Deploy and connect

You need a Sealos account and a compatible licensed PC game client.

[![Deploy on Sealos](<https://sealos.io/Deploy-on-Sealos.svg>)](<https://sealos.io/products/app-store/7daystodie/>)

1. Click **Deploy Now**, set `server_name`, and choose `max_players` (1–8; default 4).
2. Wait for the server to become Ready. Initial startup installs the game through SteamCMD and loads the Navezgane world; follow progress in the container logs.
3. Open the server's network resource card and copy the public host and the shared `game-tcp`/`game-udp` port. The template reserves four consecutive public UDP ports and TCP on the base port.
4. Retrieve the generated `ServerPassword` from the server's environment settings. In the game, choose **Join a Game → Connect to IP**, then enter the host, base port, and password.

The template starts with limits of 4 CPU cores and 8192 MiB memory. Increase resources for active players and growing worlds. The server is hidden from the public server list.

## Configuration and persistence

`ServerName`, `ServerMaxPlayerCount`, and `ServerPassword` control the name, player limit, and admission password. Restart the Pod to apply changes. Use the container terminal and `telnet 127.0.0.1 8081` for commands such as `listplayers` and `saveworld`.

A 1 GiB persistent volume stores `/home/sdtdserver/.local/share/7DaysToDie/Saves`. Save and stop the server before taking an external backup; expand storage as the world grows. Keep one replica per world. Game installation files occupy rebuildable container storage, with a 20 GiB allocation; Pod replacement downloads them again.

## Versions and support

The template pins `vinanrra/7dtd-server:v0.9.3` and LinuxGSM `v25.2.0`. `VERSION=stable` downloads Steam's current stable game during installation, so the game version can advance after Pod replacement. Back up saves and check client compatibility before restarting or upgrading.

Recorded Sealos tests covered game V3.2.0 (b10), fresh installation, public TCP/UDP queries, administration commands, and save-file preservation after Pod replacement. Licensed game-client gameplay and multiplayer capacity remain outside that test coverage.

See the [versioned template](https://github.com/labring-actions/templates/blob/bbf343d8fd5cdad7c5cec6ee80d947b66da69fba/template/7daystodie/index.yaml) and [recorded deployment checks](https://github.com/labring-actions/templates/pull/763). For template configuration, Sealos networking, and storage issues, use the [Sealos templates issue tracker](https://github.com/labring-actions/templates/issues).
