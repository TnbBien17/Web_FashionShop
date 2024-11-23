/**
 * 
 */
btnCollapse = document.getElementById("btnCollapse")
sidebar = document.getElementById("sidebar")

//const sidebarHeight = document.getElementById('sidebar-container').offsetHeight;
//const headerHeight = document.getElementById('header').offsetHeight;
//const bodyContent = document.getElementById('body-content');
//console.log(sidebarHeight - headerHeight)
//bodyContent.style.maxHeight = (sidebarHeight - headerHeight) + 'px';
//
//window.addEventListener("resize", function() {
// 	console.log(window.innerHeight);
//  	const sidebarContainerHeight = document.getElementById('sidebar-container').offsetHeight;
//	const headerHeight = document.getElementById('header').offsetHeight;
//	const bodyContent = document.getElementById('body-content');
//	bodyContent.style.maxHeight = (sidebarContainerHeight - headerHeight) + 'px';
//});

btnCollapse.onclick = () => {
	
	 if (sidebar.classList.contains("close")) {
		 sidebar.classList.remove("close");
		 sidebar.classList.add("open");
	 } else {
		 console.log(sidebar)
		 sidebar.classList.remove("open");
		 sidebar.classList.add("close");
	 }
}