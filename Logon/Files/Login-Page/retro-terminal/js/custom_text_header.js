//Custom Text Header //
 // ACSII slant font

// Needs to be inside <section id="login" class="shadow">
// YOU MUST ESCAPE ANY SINGLE BACKSLASHES LIKE SO: \\

let custom_text_header = `
<div class="custom-text-header"> <pre>   _____ __                   __          __  __(_)             
  / ___// /_  ____ _  _____  / /__       / / / / /         ___  
  \\__ \\/ __/ / __ '/ / ___/ / //_/      / /_/ / / | | / / / _ \\ 
 ___/ / /_  / /_/ / / /    / ,&lt;        / __  / /  | |/ / /  __/ 
/____/\\__/  \\__,_/ /_/    /_/|_|      /_/ /_/_/   |___/  \\___/  </pre> </div>
`;
document.getElementById("login").innerHTML += custom_text_header


// Replace default Unraid logo with Bees Hive GIF
let logoContainer = document.querySelector('.logo.angle .wordmark');
if (logoContainer) {
    logoContainer.innerHTML = '<img src="https://media.tenor.com/WusSRICR92EAAAAj/bees-hive.gif" alt="Bees Hive" style="height: 55px; width: auto; object-fit: contain;">';
}
