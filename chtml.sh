#!/bin/bash

function chtml() {

    fail=false
    for f in *.chtml; do

        echo "processing $f..."

        #gets name of the .chtml file, f
        IFS="."
        read -ra arr <<< "$f"

        out="${arr[0]}.html"
        rm -f "$out"

        #parses chtml file line by line
        l=0
        while IFS= read -r line; do

            ((l++))

            IFS="{}"
            read -ra lrr <<< "$line"
            len=${#lrr[@]}
            
            #checks if line matches input format
            if (( $len == 2 )) && [[ ${lrr[0]} =~ ^\ *$ ]] && ! [[ ${lrr[1]} =~ ^\ *$ ]]; then
                
                #extracts and outputs included file
                space="${lrr[0]}"
                temp="${lrr[1]}"
                if test -f "$temp"; then
                    while read -r tline; do
                        echo "$space$tline" >> "$out"
                    done < "$temp"
                else
                    fail=true
                    echo "Input File Error: \"$temp\" Not Found"
                    echo "$f:$l:$line"
                    break
                fi

            else
                echo "$line" >> "$out"
            fi

            if [ $fail = "true" ]; then break; fi

        done < "$f"
        
        if [ $fail = "true" ]; then break; fi

    done

}


