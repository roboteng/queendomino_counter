List<int> range(int end) {
  assert(end >= 0);
  List<int> list = [];
  int i = 0;
  while (!list.contains(end)) {
    list.add(i);
    i++;
  }
  return list;
}
