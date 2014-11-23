<h1>4get</h1>
<h2>A simple yet powerfull 4chan thread downloader</h2>

Downloads all images, including the OP, in a folder sorted on board and thread number.
Checks if a file has been downloaded already, to save bandwidth and make sure no duplicates are downloaded.

<h3>usage:</h3>
- -h) shows help
- -P [arg]) set destination path
- -d) clear default directory (~/Pictures/4chan/)

<h3>Tips:</h3>
- Use -P as a way to tag on subject.
- Change the default download directory by editing the main script.

<h4>Dependencies</h4>
- awk
- curl
- sed
- uniq
- wget
