# Decompressor

Code in nvim
![image](https://user-images.githubusercontent.com/114973749/218240673-abb63172-cdf3-430c-bb9b-322764a4e52e.png)

Hace un tiempo he venido obteniendo soltura en Bash, y para practicar un poco scripting con bandit he terminado desarrollando un pequeño script en bash para descomprimir un archivo que tiene una cantidad desconocida de archivos comprimidos en su interior, específicamente para bandit12, el script es útil porque no tienes que estar mirando y descomprimiendo uno por uno los archivos que tiene el archivo en su interior. Una vez descomprimido el archivo de bandit14 llamado **content.gzip**, por lo que no hay necesidad de saber si el nuevo archivo esta comprimido de nuevo y hacer el mismo proceso repetitivo.

El Script de Decompressor hace lo siguiente:
1. Teniendo el archivo **content.gzip**, el script leerá el último argumento del archivo adentro del comprimido.
2. Entrará en un bucle, siempre y cuando el último argumento sea también de tipo comprimido.
3. De ser así, seguirá descomprimiéndose hasta que ya no quede un archivo de tipo comprimido.
4. Decompressor sabra cuando el ultimo argumento no sea un archivo comprimido, asi que aplica un `/bin/cat` al archivo resultante.
5. Decompressor ayuda a acceder al contenido mucho mas rapido que si lo hicieramos descomprimiendo archivo por archivo.
6. El Script hace uso de sentencias de selección (if, else).
7. Usando `7z l **content.gzip**`, lo que haremos es listar el contenido del archivo sin extraerlo.
8. El uso de' grep `"Name" -A 2`, significa que grep buscará un patron en el stdout del comando `7z l al archivo content.gzip` y lo mostrara en pantalla.
9. Al hacer uso de `tail -n 1`, grep solo mostrara la ultima coincidencia con el patron "Name".
10. El comando `awk 'NF{print NF}'` Esto nos permite obtener únicamente el nombre del archivo descomprimido.
Finalmente, el nombre del archivo descomprimido se asigna a la variable `name_decompressed`.

### Codigo del Script

> Para mayor entendimiento del script y lo que hace, recomiendo probar un poco experimentar con los comandos grep, tail, awk y sus parámetros:


```bash
#!/bin/bash

name_decompressed=$(7z l content.gzip | grep "Name" -A 2 | tail -n 1 | awk 'NF{print $NF}')
7z x  content.gzip > /dev/null 2>&1

while true; do
	7z l $name_decompressed > /dev/null 2>&1
	if [ "$(echo $?)" == "0" ]; then
		decompressed_next=$(7z l $name_decompressed | grep "Name" -A 2 | tail -n 1 | awk 'NF{print $NF}')
		7z x $name_decompressed > /dev/null 2>&1 && name_decompressed=$decompressed_next
	else
		cat $name_decompressed; rm data* 2>/dev/null
		exit 1
	fi
done
```

Para usar correctamente Decompressor, al estar en el bandit14, hay que cambiar el nombre del archivo a **content.gzip**, de esta forma funcionara sin problemas.

Para conseguir el **content.gzip**, hacemos lo siguiente:
```bash
liann@nk:~/bandit14$ 
└──╼ $ls
data.hex
liann@nk:~/bandit14$
└──╼  $xxd -r data.hex > data
liann@nk:~/bandit14$ 
└──╼ $file data
data: gzip compressed data, was 'data2.bin' .......
liann@nk:~/bandit14$ 
└──╼ $mv data content.gzip
liann@nk:~/bandit14$ 
└──╼ $ ./decompressor content.gzip
The password is .....
```

El Script es compilado y funciona correctamente

> A small script in bash to decompress a file that has a unknown amount of compressed files inside of it for bandit14,
the script it's usefull because you do not have to be looking one by one the files.
Once you decompressed content.gzip there is no need to know if the new file it's compressed again and do the same repetitive process.

Code in nvim
![image](https://user-images.githubusercontent.com/114973749/218240673-abb63172-cdf3-430c-bb9b-322764a4e52e.png)

Decompressor will check the last argument of the file using 7z and if it is a compressed file it will check again and again until there is no need. 



Decompressor knows that the last argument is not a compressed file, and it can not be decompressed so it applies a /bin/cat to the file and we have the content much faster than going one by one decompressing all the files.

https://user-images.githubusercontent.com/114973749/218285322-b1da8470-b1fd-4a3e-818e-104c0e05f3c9.mp4

