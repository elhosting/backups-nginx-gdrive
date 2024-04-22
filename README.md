# backups-nginx-gdrive

Los scripts adjuntos se alojan en la carpeta `/usr/local/bin`.

Los archivos de backup se alojan en la carpeta ```/root/backups```, la cual se sincroniza con Google Drive mediante `gclone`.

## Crontab

```
# m h  dom mon dow   command
1 3 * * 1-6 backup_site.sh /var/www/toquiseeds/ toquiseeds_inc
1 3 * * 1-6 backup_site.sh /var/www/puraciudad.com.ar/ puraciudad_inc
10 3 * * * backup_db.sh /var/www/toquiseeds/
10 3 * * * backup_db.sh /var/www/puraciudad.com.ar/
1 3 * * 0 zip -r /root/backup/toquiseeds_total.zip /var/www/toquiseeds/
1 3 * * 0 zip -r /root/backup/puraciudad_total.zip /var/www/puraciudad.com.ar/
30 3 * * * rclone sync /root/backup/ gdrive:backup >>/dev/null 2>&1
```

