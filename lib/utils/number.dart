String number(value, {String separator=',', String trailing=""}) {
  return value.toString().replaceAllMapped(
    new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}$separator'
  ) + trailing;
}