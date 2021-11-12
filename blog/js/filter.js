function filterPosts() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("searchparam");
    filter = input.value.toUpperCase();
    table = document.getElementById("blogposts");
    tr = table.getElementsByTagName("tr");
    console.log('hi')
    for (i = 1; i < tr.length; i++) {
        // Hide the row initially.
        tr[i].style.display = "none";
        td = tr[i].getElementsByTagName("td");
        for (var j = 0; j < td.length; j++) {
            cell = tr[i].getElementsByTagName("td")[j];
            if (cell) {
                if (cell.innerHTML.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
                break;
                } 
            }
        }
    }
}