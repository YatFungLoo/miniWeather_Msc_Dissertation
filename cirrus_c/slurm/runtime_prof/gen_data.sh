rm -rf data.csv;
echo "exec,time,steps" >> data.csv;
for i in *.out; do bash get_data.sh "$i"; done