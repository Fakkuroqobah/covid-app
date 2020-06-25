String dateIndonesia(DateTime date, {bool shortMonth=false}) {
	return "${date.day} ${_convertToLocalMonth(date.month, shortMonth)} ${date.year}";
}

List _longMonth = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
List _shortMonth = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];

String _convertToLocalMonth(int month, bool shortMonth) {
	if (shortMonth) return _shortMonth[month -1];
	return _longMonth[month - 1];
}