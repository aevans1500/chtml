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
                
                #checks if arguments are of valid format
                IFS=" "
                read -ra argarr <<< "${lrr[1]}"
                arglen=${#argarr[@]}
                val=true
                for ((i = 1 ; i < $arglen ; i++)); do
                    if ! [[ "${argarr[$i]}" =~ ^.+:.+$ ]]; then
                        val=false
                        break
                    fi
                done
                if [ "$val" == "false" ]; then
                    echo "Invalid Arguement Error"
                    echo "$f:$l:$line"
                    break
                fi
                IFS=" :"
                read -ra allarg <<< "${lrr[1]}"
                allarglen=${#allarg[@]}

                #extracts and outputs included file
                space="${lrr[0]}"
                temp="${argarr[0]}"
                if test -f "$temp"; then

                    while IFS= read -r tline; do

                        IFS=" "
                        read -ra trr <<< "$tline"
                        tlen=${#trr[@]}

                        linepart="$space"

                        #inputs and handles arguments as necessary
                        for ((i = 0 ; i < $tlen ; i++)); do

                            if [[ "${trr[$i]}" =~ ^~[0123456789]*$ ]]; then

                                for ((j = 1 ; j < $allarglen ; j += 2)); do 

                                    if [ "${trr[$i]}" = "~${allarg[$j]}" ]; then
                                        ((index = $j + 1))
                                        linepart="$linepart${allarg[$index]} "
                                        break
                                    fi

                                done

                            else
                                linepart="$linepart${trr[$i]} "
                            fi
                        done

                        echo "$linepart" >> "$out"

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


