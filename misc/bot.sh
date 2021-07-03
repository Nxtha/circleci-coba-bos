#! /bin/bash

if [ ! -z "$1" ];then
    if [ "$1" == "send_info" ];then
        msg="$2"
        msg=${msg/"&"/"%26"}
        if [ ! -z "$3" ];then
            curl -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d chat_id="$3" \
            -d "disable_web_page_preview=true" \
            -d "parse_mode=html" \
            -d text="$msg"
        else
            curl -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d chat_id="-1001467576014" \
            -d "disable_web_page_preview=true" \
            -d "parse_mode=html" \
            -d text="$msg"
        fi
    fi
    if [ "$1" == "send_files" ];then
        msg="$3"
        msg=${msg/"&"/"%26"}
        if [ ! -z "$4" ];then
            curl --progress-bar -F document=@"$2" "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
            -F chat_id="$4"  \
            -F "disable_web_page_preview=true" \
            -F "parse_mode=html" \
            -F caption="$msg"
        else
            curl --progress-bar -F document=@"$2" "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
            -F chat_id="-1001350392415"  \
            -F "disable_web_page_preview=true" \
            -F "parse_mode=html" \
            -F caption="$msg"
        fi
    fi
    if [ "$1" == "send_sticker" ];then
     SID=CAACAgUAAxkBAAECf_5g2twK9g8uhgdLBDwuGMI9b0pdqAAC0QEAAtvY6VUbbyn3P7EPPyAE
     
       curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendSticker" \
        -d sticker="$SID" \
        -d chat_id="-1001467576014"
    fi    
fi

# from https://gist.github.com/cdown/1163649
# urlencode() {
#     # urlencode <string>

#     old_lc_collate=$LC_COLLATE
#     LC_COLLATE=C

#     local length="${#1}"
#     for (( i = 0; i < length; i++ )); do
#         local c="${1:$i:1}"
#         case $c in
#             [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
#             *) printf '%%%02X' "'$c" ;;
#         esac
#     done

#     LC_COLLATE=$old_lc_collate
# }

# urldecode() {
#     # urldecode <string>

#     local url_encoded="${1//+/ }"
#     printf '%b' "${url_encoded//%/\\x}"
# }