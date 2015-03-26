todo's:
- ~~create a dotfile system for auto updating.~~
- ~~give every path a dotfile for saving links.~~ deprecated by recent update
- ~~add option to discard creation of dotfiles.~~
- ~~make the -d function work for folders outside of the default directory.~~ bad idea
- add more features
- shitpost furiously


<h1>4get</h1>
<h3>A simple yet powerfull 4chan thread downloader</h3>

Downloads all images, including the OP, in a folder sorted on board and thread number.
Checks if a file has been downloaded already, to save bandwidth and make sure no duplicates are downloaded.
Is able to keep a list of downloads, so you can update automagically.

<h4>Usage:</h4>
- -d)        empty default path
- -a [url])  add to update list
- -u)        update all pages in your update list
- -l)        list update list
- -c)        clears update list
- -h)        display this help
- -P [dir])  enter required path

<h4>Tips:</h4>
- Use -P as a way to tag on subject.
- Create a syslink in your $PATH and rename it to "4get", this way it works like any other command!
- Change the default download directory by editing the main script.
- 4get does not download new images automatically unless you added the threads to your update list.
- It updates only when you tell it to do so.
- 4chan might host illegal content, I am not responisble for what is downloaded by this tool.

<h4>Dependencies:</h4>
Most if not all will already be installed on your system!
- awk
- curl
- grep
- sed
- uniq
- wget
- seq
