# for i in *.out; do bash get_data.sh "$i"; done
grep "EXEC_NAME" "$1" | awk '{printf $2}' >> data.csv;
echo -n "," >> data.csv;
grep "CPU Time" "$1" | awk '{printf $3}' >> data.csv;
echo -n "," >> data.csv;
grep "Elapsed Time:" "$1" | awk '{print $5}' | head -1 >> data.csv;
