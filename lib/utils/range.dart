List<int> range(int end) {
  print('end: $end');
  assert(end >= 0);
  List<int> list = [];
  int i = 0;
  while (!list.contains(end)) {
    list.add(i);
    i++;
  }
  print('List: $list');
  return list;
}
