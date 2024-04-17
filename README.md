# backups-nginx-gdrive

EL script adjunto se aloja en la carpeta `/scripts` del home del usuario `root`

Los backups se alojan en la carpeta ```/backups``` del mismo home. Esta carpeta se sincroniza con Google Drive mediante `gclone`.

Los scripts incrementales se corren diariamente mediante el `crontab`

```
# m h  dom mon dow   command
*/15 * * * * wget -O /dev/null -o /dev/null https://toquiseeds.com/wp-cron.php?doing_wp_cron >/dev/null 2>&1
*/15 * * * * wget -O /dev/null -o /dev/null https://puraciudad.com.ar/wp-cron.php?doing_wp_cron >/dev/null 2>&1
8 3 * * * backup_site.sh /var/www/toquiseeds/ toquiseeds_inc
8 3 * * * backup_site.sh /var/www/puraciudad.com.ar/ puraciudad_inc
9 3 * * * rclone sync /root/backup/ gdrive:backup >/dev/null 2>&1
```

