## OpenRP Extras

OpenRP Extras is an addon for OpenRP 2.3.5 written in DenizenScript, intending to add a few features which many servers need but which many lack.

Features:
- Force capitalization in specific channels.
- Regex pattern matching in description fields.
- Language channels feature, supporting as many channels as needed.

### Compatibility

The scripts included are meant to be compatible with **OpenRP 2.3.5**, and the **latest DenizenScript**. They may be compatible with other versions too, but I make no guarantees of that.

### Installation

OpenRP Extras is written in DenizenScript, so you will first need to install Denizen first.  
Denizen[https://denizenscript.com]

**Restart your server after installing Denizen.**

Next, head over to Releases[https://github.com/fishydarwin/OpenRP-Extras/releases] and download the latest version of OpenRP Extras.

Open the .zip file, which will contain a folder called `OpenRP-Extras`.  
This folder must be placed inside `plugins/Denizen/scripts`.

Lastly, open the Denizen config.yml file and change the following lines:
```yaml
    # Whether to allow the 'reflectionset' command. This command is highly abusable and should be left disabled.
    Allow set command: true
    # Whether the 'reflectionset' command may set to 'private' fields. This is very likely to be dangerous if enabled.
    Allow set private fields: true
```
The reason this is required is for manipulating OpenRP chat events, so that the message may be replaced with the forced-capitalized or language-replaced version. If you do not trust the script, feel free to read & inspect the code; I promise the use of `reflectionset` is justified.

To complete the installation, run `/ex reload` in game or from console.

### Usage

For usage/configuration, please join the OpenRP Discord and read the #openrp-extras channel.
Discord[https://discord.gg/KvVqBm9hbu]

### Why use Denizen?

Since OpenRP 2 was released in December of 2019, I haven't found myself having the time to keep it properly updated and to add new features. There are a few features which I would love to add, but because of studies, personal studies.
