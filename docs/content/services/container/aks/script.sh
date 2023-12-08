for i in {8..10};
do
  cd code
  mkdir aks-$i
  cd aks-$i
  echo "// under-development" > aks-$i.kql
  cd ..
done
