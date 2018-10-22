# script for populating data, requires PARSE_APPLICATION_ID and PARSE_MASTER_KEY to be exported

for A in arrow laser lobster circus rose duck cot door
do
  for B in uniform straw newspaper attack shampoo grasshopper foam shirt
  do
    for I in foo bar everbody wang chung tonite wooo yeaaa what cheeze kitties stuff pixels
    do
      CAT_ID=`sh post.sh "{\"description\": \"$I $A $B\"}" http://kicksass-db/classes/ItemCategory`
      echo $CAT_ID
      for J in zoo bar baz whim wham numchucks stuff morestuff and
      do
        for K in Egypt reform cucumber socks rash observation printer refugee
        do
          sh post.sh "{\"constrained\": true, \"costInPoints\": 100, \"filename\": \"foo\", \"frames\": 1, \"itemCategoryId\": $CAT_ID, \"name\": \"$J $K\", \"quantityAvailable\": 100, \"variations\": 1}" http://kicksass-db.app.dev.mavenlink.net/1/classes/FunItem
        done
      done
    done
  done
done
