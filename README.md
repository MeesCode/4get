<h1>4get</h1>
<h3>A simple yet powerfull 4chan thread downloader</h3>

Downloads all images, including the OP, in a folder sorted on board and thread number.
Checks if a file has been downloaded already, to save bandwidth and make sure no duplicates are downloaded.

<h4>usage:</h4>
- -h) shows help
- -P [arg]) set destination path
- -d) clear default directory (~/Pictures/4chan/)

<h4>Tips:</h4>
- Use -P as a way to tag on subject.
- Change the default download directory by editing the main script.
- 4get does not download new images automatically.
- 4chan might host illegal content, I am not responisble for what is downloaded by this tool.

<h4>Dependencies:</h4>
- awk
- curl
- grep
- sed
- uniq
- wget
