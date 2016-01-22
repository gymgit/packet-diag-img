# packet-diag-img

This is a little script to convert dformat typesetting files to PNG images.

## Requirements and Usage

Use `git clone --recursive https://github.com/gymgit/packet-diag-img.git` to clone the converter script and the original awk script as well, otherwise the conversion will not work.

##### Required packages:

* awk/gawk
* groff
* ghost script
* Image Magick

Most distributions have these packages preinstalled, if not the following commands can be used to install them:

```
apt-get install gawk imagemagick  ghostscript groff
```
or if yout distribution uses Yum:
```
yum install ImageMagick gawk groff ghostscript
```

##### Usage:
```
$ sh packet-diag.sh [OPTIONS] INPUT OUTPUT
```
##### Options:

* -s/--scale used to scale down the size of the resulting image, it is the percentage of the original size, default: 100
* -b/--border adds a transparent border to the image, default: 15 (pixels)

## Examples

The comprehensive documentation of the dformat syntax is available in the doc folder in the [dformat.pdf](https://github.com/gymgit/packet-diag-img/blob/master/doc/dformat.pdf). Here are two examples to demonstrate the usage of the script.

##### Input:
```
.EQ
.EN
.begin dformat
style bitwid 0.08
style charwid 0
style recspread 0.3
style linethrutext 0
ISO over tcp
        4--12 TPKT
        3--9 ISO-COTP
  A1:   --30 S7 PDU
S7PDU
  A2:   10--12 Header
        --14 Parameters
  A3:   --25-dashed Data

pic line dotted from A1.sw to A2.nw
pic line dotted from A1.se to A3.ne
.end
```
##### Command:

`./packet-diag.sh -s 50 -b 20 sample/s7_packet.txt sample/s7_packet.png`

##### Result:

![s7packet](/sample/s7_packet.png)

##### Input:

```
.begin dformat
style bitwid 0.05
style linethrutext 0
Userdata
        0-23 Protocol Constant
        24-31 Length
		32-39 Origin
		40--4 Send Type
		44--4 Message Function
		48-55 Subfunction
		56-63 Sequence
		64-71-8-dashed Data Reference
		72-79-8-dashed Last Data Unit
		80-95-16-dashed Error Code
.end
```

##### Command:

`./packet-diag.sh -s 50 sample/s7_userdata.txt sample/s7_userdata.png`

##### Result:

![s7userdata](/sample/s7_userdata.png)

## Limitations

There are a few known limitations, the original dformat script cannot handle the DOS/windows CRLF line trailing sequence, so the input text file must have unix line endings.

The output file format is limited to PNG because some formats cannot handle transparency and I was too lazy to fix the script for these. You can use ImageMagick's `convert` tool to convert the output to virtually any format.
