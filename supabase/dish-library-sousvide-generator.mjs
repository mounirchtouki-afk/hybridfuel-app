import { writeFileSync } from "node:fs";
// Ingrediënt-macro's per 100g (hergebruikt bestaande slugs + nieuwe sous-vide eiwitten)
const IMAP = {
  chicken_breast:{nl:"Kipfilet (gegrild)",en:"Chicken breast",kcal:165,p:31,c:0,f:3.6},
  chicken_thigh:{nl:"Kipdij",en:"Chicken thigh",kcal:177,p:24,c:0,f:9},
  beef_steak:{nl:"Biefstuk",en:"Beef steak",kcal:187,p:27,c:0,f:8},
  flat_iron:{nl:"Flat iron steak",en:"Flat iron steak",kcal:191,p:23,c:0,f:11},
  lamb_fillet:{nl:"Lamsfilet",en:"Lamb fillet",kcal:201,p:25,c:0,f:11},
  pork_tenderloin:{nl:"Varkenshaas",en:"Pork tenderloin",kcal:143,p:26,c:0,f:4},
  duck_breast:{nl:"Eendenborst (zonder vel)",en:"Duck breast (skinless)",kcal:201,p:23.5,c:0,f:11},
  salmon:{nl:"Zalmfilet",en:"Salmon fillet",kcal:208,p:20,c:0,f:13},
  white_fish:{nl:"Kabeljauw",en:"Cod",kcal:82,p:18,c:0,f:0.7},
  shrimp:{nl:"Garnalen",en:"Shrimp",kcal:99,p:24,c:0.2,f:0.3},
  egg:{nl:"Ei",en:"Egg",kcal:143,p:13,c:1,f:10},
  // koolhydraten
  sweet_potato:{nl:"Zoete aardappel",en:"Sweet potato",kcal:86,p:1.6,c:20,f:0.1},
  potato:{nl:"Aardappel",en:"Potato",kcal:77,p:2,c:17,f:0.1},
  rice_dry:{nl:"Witte rijst (droog)",en:"White rice (dry)",kcal:360,p:7,c:79,f:1},
  quinoa_dry:{nl:"Quinoa (droog)",en:"Quinoa (dry)",kcal:368,p:14,c:64,f:6},
  // groente
  broccoli:{nl:"Broccoli",en:"Broccoli",kcal:34,p:2.8,c:7,f:0.4},
  green_beans:{nl:"Sperziebonen",en:"Green beans",kcal:31,p:1.8,c:7,f:0.1},
  asparagus:{nl:"Asperges",en:"Asparagus",kcal:20,p:2.2,c:3.9,f:0.1},
  spinach:{nl:"Spinazie",en:"Spinach",kcal:23,p:2.9,c:3.6,f:0.4},
  zucchini:{nl:"Courgette",en:"Zucchini",kcal:17,p:1.2,c:3.1,f:0.3},
  // vet/afwerking
  olive_oil:{nl:"Olijfolie",en:"Olive oil",kcal:884,p:0,c:0,f:100},
  butter:{nl:"Roomboter",en:"Butter",kcal:717,p:0.9,c:0.1,f:81},
};
const macros=(items)=>{let k=0,p=0,c=0,f=0;for(const it of items){const m=IMAP[it.slug];const g=it.g/100;k+=m.kcal*g;p+=m.p*g;c+=m.c*g;f+=m.f*g;}return{kcal:Math.round(k),p:Math.round(p),c:Math.round(c),f:Math.round(f)};};
const slug=(s)=>s.toLowerCase().normalize("NFD").replace(/[̀-ͯ]/g,"").replace(/[^a-z0-9]+/g,"_").replace(/^_|_$/g,"");
const dishes=[]; const used=new Set();
function add(nl,en,moments,items,prefs=[]){const key=slug(en);if(used.has(key))return;used.add(key);const mac=macros(items);const goals=[];if((mac.p*4)/Math.max(1,mac.kcal)>=0.30&&mac.kcal<=700)goals.push("cut");if(mac.kcal>=600)goals.push("gain");goals.push("maintain");dishes.push({slug:key,nl,en,moments,goals:[...new Set(goals)],items,tags:["sousvide","high_protein"],prefs});}

// Sous-vide eiwitten met kern-temp (naam encodeert techniek + temp)
const SV=[
  ["chicken_breast","Kip sous-vide 63°C","Sous-vide chicken 63°C",160,["chickenrice","ricechicken"]],
  ["chicken_thigh","Kipdij sous-vide 74°C","Sous-vide chicken thigh 74°C",150,[]],
  ["beef_steak","Biefstuk sous-vide 54°C (medium-rare)","Sous-vide steak 54°C (medium-rare)",150,["steakpotato"]],
  ["flat_iron","Flat iron steak sous-vide 54°C","Sous-vide flat iron steak 54°C",150,["steakpotato"]],
  ["lamb_fillet","Lamsfilet sous-vide 54°C","Sous-vide lamb fillet 54°C",150,[]],
  ["pork_tenderloin","Varkenshaas sous-vide 58°C","Sous-vide pork tenderloin 58°C",150,[]],
  ["duck_breast","Eendenborst sous-vide 56°C","Sous-vide duck breast 56°C",140,[]],
  ["salmon","Zalm sous-vide 50°C","Sous-vide salmon 50°C",150,["salmonveg"]],
  ["white_fish","Kabeljauw sous-vide 52°C","Sous-vide cod 52°C",170,[]],
  ["shrimp","Garnalen sous-vide 57°C","Sous-vide shrimp 57°C",150,[]],
];
const CARB=[["sweet_potato","zoete aardappel","sweet potato",200],["potato","aardappel","potato",250],["rice_dry","rijst","rice",70],["quinoa_dry","quinoa","quinoa",70]];
const VEG=[["broccoli","broccoli","broccoli",120],["green_beans","sperziebonen","green beans",120],["asparagus","groene asperges","green asparagus",120],["spinach","spinazie","spinach",100],["zucchini","courgette","zucchini",120]];
const fishProt=new Set(["salmon","white_fish","shrimp"]);
for(const [ps,pnl,pen,pg,pprefs] of SV){
  for(const [cs,cnl,cen,cg] of CARB){
    // vis combineert niet met zware zetmeel-overload: skip quinoa voor garnalen om herhaling te beperken
    for(const [vs,vnl,ven,vg] of VEG){
      const fat = fishProt.has(ps) ? {slug:"olive_oil",g:7} : {slug:"butter",g:8};
      const items=[{slug:ps,g:pg},{slug:cs,g:cg},{slug:vs,g:vg},fat];
      // naam: "<Eiwit sous-vide temp> met <carb> & <veg>"
      add(`${pnl} met ${cnl} & ${vnl}`,`${pen} with ${cen} & ${ven}`,["dinner","lunch"],items,pprefs);
    }
  }
}
// Onsen-ei ontbijt/lunch extra's
add("Onsen-ei 63°C op volkoren toast met avocado","Onsen egg 63°C on wholegrain toast with avocado",["breakfast","lunch"],[{slug:"egg",g:120},{slug:"potato",g:0},{slug:"olive_oil",g:3}].filter(x=>x.g>=0&&x.slug!=="potato").concat([{slug:"spinach",g:40}]),[]);

// ---- SQL ----
const esc=(s)=>s.replace(/'/g,"''");
const usedSlugs=new Set();dishes.forEach(d=>d.items.forEach(it=>usedSlugs.add(it.slug)));
let sql="-- SOUS-VIDE batch (core). Draai NA dish-library.sql (en mag na de hoofd-seed).\nbegin;\n";
sql+="insert into public.ingredients (slug,name_nl,name_en,kcal,protein,carbs,fat,category,source) values\n";
sql+=[...usedSlugs].map(s=>{const m=IMAP[s];const cat=/steak|iron|lamb|duck|chicken|pork|beef/.test(s)?"vlees":/salmon|fish|shrimp/.test(s)?"vis":/oil|butter/.test(s)?"vet":/potato|rice|quinoa/.test(s)?"granen":/broccoli|bean|aspar|spin|zucch/.test(s)?"groente":"overig";return `('${s}','${esc(m.nl)}','${esc(m.en)}',${m.kcal},${m.p},${m.c},${m.f},'${cat}','core')`;}).join(",\n");
sql+="\non conflict (slug) do nothing;\n\n";
sql+="insert into public.dishes (slug,name_nl,name_en,moments,goals,items,tags,prefs,source) values\n";
sql+=dishes.map(d=>`('${d.slug}','${esc(d.nl)}','${esc(d.en)}',ARRAY[${d.moments.map(m=>`'${m}'`).join(",")}],ARRAY[${d.goals.map(g=>`'${g}'`).join(",")}],'${JSON.stringify(d.items.map(it=>({slug:it.slug,g:it.g})))}'::jsonb,ARRAY[${d.tags.map(t=>`'${t}'`).join(",")}]::text[],ARRAY[${d.prefs.map(p=>`'${p}'`).join(",")}]::text[],'core')`).join(",\n");
sql+="\non conflict (slug) do nothing;\ncommit;\n";
writeFileSync(new URL("./sousvide-seed.sql",import.meta.url),sql);
console.log("sous-vide gerechten:",dishes.length);
dishes.slice(0,5).forEach(d=>{const m=macros(d.items);console.log("  •",d.nl,"→",m.kcal+"kcal",m.p+"p/"+m.c+"c/"+m.f+"f");});
