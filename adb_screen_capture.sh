#adb_screen_capture() {
#  usage=""$FUNCNAME" [-h] [-d display] [-f file_name] -- program to calculate the answer to life, the universe and everything
  usage="$(basename "$0") [-h] [-d display] [-f file_name] -- program to calculate the answer to life, the universe and everything
    where:
      -h  show this help text
      -d display to capture screen of (default is 0)
      -f file name (default is adb_screenshot)"
  display=0
  file_name="$(date +'%F_%H%M%S')_screenshot.png"
  directory="/home/$USER/Pictures/adb_screen_captures"

  #local OPTIND OPTARG
  while getopts 'hd:f:' option; do
    case "$option" in
      h) echo "$usage"; 
          exit;;
      d) display=$OPTARG
          ;;
      f) file_name="$OPTARG.png"
          ;;
      \?) printf "illegal option: -%s\n" "$OPTARG" >&2; echo "$usage" >&2; exit 1;;
    esac
  done

  #echo $display
  #echo $file_name
  adb shell screencap -p -d $display /sdcard/$file_name
  adb pull /sdcard/$file_name
  adb shell rm /sdcard/$file_name
  mkdir -p "$directory"
  mv $file_name $directory/$file_name
  echo "saved to $directory/$name"
#
