/* *****************************************************
//  INS JOAN D'AUSTRIA
//	CFGS ASIX DAM DAW
//	M2: Bases de dades. UF3: Extensió procedimental
//	PRÀCTICA UF3. FASE 
//	AUTOR: DAMIAN MOLIN
//	DATA: 
****************************************************** */

/*Requeriment 1:
Nom: treureEspais
Entrada: cadena de caràcters
Sortida: cadena de caràcters
Descripció: Retorna la mateixa cadena de caràcters rebuda com a entrada però sense cap 
espai en blanc. Per exemple: Entrada: “ H ol a ”  Sortida: “Hola”
Gestió d’errors: Si la cadena d’entrada és el valor NULL cal retornar una cadena buida 
*/

create or replace function treureEspais 
(palabraSucia varchar2) 
return varchar2 
is
  palabraLimpia varchar2(50);
BEGIN
	palabraLimpia := replace(palabraSucia,' ','');
    return palabraLimpia;
END;
/
/* PRUEBA:
BEGIN
    dbms_output.put_line(treureEspais('   h  ola  '));
end;
/
*/






/*
Requeriment 2:
Nom: kgToLliures
Entrada: Numèric amb un decimal
Sortida: Numèric sense decimals
Descripció: Converteix un número que representarà un pes en kg al mateix pes en 
lliures. Com a mesura de conversió podeu agafar que 1 kg = 2.2046 lb. Per exemple, 
entrada: 100.0  sortida: 220
*/

create or replace function kgToLliures 
(numeroSucio number) 
return number 
is
  numeroLimpio number;
BEGIN
  numeroLimpio := trunc(numeroSucio * 2.2046);
  return numeroLimpio;
END;
/

/* PRUEBA:
BEGIN
    dbms_output.put_line(kgToLliures(4));
end;
/
*/











/*
Requeriment 3:
Nom: lliuresToKg
Entrada: Numèric sense decimals
Sortida: Numèric amb un decimal
Descripció: Converteix un número que representarà un pes en lliures al mateix pes en 
kilograms. Com a mesura de conversió podeu agafar que 2.2046 lb = 1 kg 


2.2 --- 100
1 ----- 220.46

Per exemple, 
entrada: 220  sortida: 99.8
*/

create or replace function lliuresToKg
(numeroSucio number) 
return number 
is
  numeroLimpio number;
BEGIN
  numeroLimpio := round((numeroSucio /2.2046) ,1);
  return numeroLimpio;
END;
/

/*
BEGIN
    dbms_output.put_line(lliuresToKg(220));
end;
*/










/*
Requeriment 4:
Nom: peusToCm
Entrada: cadena de caràcters
Sortida: Numèric amb un decimal

Descripció: Converteix la cadena de caràcters que rebem a l’entrada que representarà 
una alçada en peus i polzades a una alçada en centímetres. 
El format d’entrada serà X-YY on X representa els peus i YY les polzades. 

Cal tenir present que potser hi ha espais en blanc en la cadena d’entrada. 

Podeu agafar com a mesures de conversió que 
100 centimetros = 3.2808399 peus 
i a la inversa 2.54cm = 1 polzada. 
12 polzades = 1 peu i per tant 1 peu = 2.54X12 = 30.5cm. 

---------------------------------------------------------------------------------------

Per exemple: 

Entrada: “7-00”  
Sortida: 213.4

Entrada: 
“6-03” 
Sortida: 190.5
*/




create or replace function peusToCm(piesPulgadas varchar2) 
return number 
is
  pies number;
  pulgadas number;
  alturaCm number;
BEGIN
  piesPulgadas := replace(piesPulgadas, ' ', ''); 
  pies := substr(piesPulgadas, 1, instr(piesPulgadas, '-')-1); 
  pulgadas := substr(piesPulgadas, instr(piesPulgadas, '-')+1); 
  alturaCm := ((pies * 12) + pulgadas) * 2.54; 
  return round(alturaCm, 1); 
END;
/


create or replace function peusToCm_Pruebas (numeroSucio varchar2) 
return number 
is
  numeroLimpio number := 0;
  cadenaUno varchar2(15);
  cadenaDos varchar2(15);
  longitudCadena number;
  longitudGuion number;

BEGIN
  longitudCadena := length(numeroSucio);
  longitudGuion := instr(numeroSucio,'-');
  /*divido las dos cadenas*/
  cadenaUno := substr(numeroSucio,1,longitudGuion-1);
  cadenaDos := substr(numeroSucio,longitudGuion+1,longitudCadena);
  return numeroLimpio;
END;
/

/*
BEGIN
    dbms_output.put_line(peusToCm('1234-67'));
end;
*/














/*
Requeriment 5:
Nom: cmToPeus
Entrada: Numèric amb un decimal
Sortida: cadena de caràcters
Descripció: Converteix el número que rebem a l’entrada que representarà una alçada en 
centímetres a una alçada en peus i polzades. El format de sortida serà X-YY on X 
representa els peus i YY les polzades. Podeu agafar com a mesures de conversió que 1 
metre = 3.2808399 peus i a la inversa 2.54cm = 1 polzada. 12 polzades = 1 peu i per 
tant 1 peu = 2.54X12 = 30.5cm. Per exemple: Entrada: 213.5  Sortida: “7-00” o 
Entrada: 190.0  Sortida: “6-23” 
*/

create or replace function cmtopeus_pruebas(
							altura NUMBER
							)
							return varchar2 
IS
	peus number;
	resto number;
	polzada number;
BEGIN
	peus:=trunc(altura / 30.5);
	resto:=mod(altura, 30.5);
	polzada:=trunc(resto/2.54);
	return peus || '-' || polzada;
end;
/

create or replace function cmToPieus(alturaCm number) 
return varchar2 
is
  pies number;
  pulgadas number;
  alturaPieus varchar2(5);
BEGIN
  pies := trunc(alturaCm / 30.48); 
  pulgadas := round((alturaCm - (pies * 30.48)) / 2.54); 
  alturaPieus := pies || '-' || pulgadas; 
  return alturaPieus;
END;
/












/*
Requeriment 6:
Nom: posicioToString
Entrada: cadena de caràcters
Sortida: cadena de caràcters

Descripció: Converteix la cadena de caràcters que rebem a l’entrada que representarà la o les posicions que ocupa un jugador a format llarg. 

La codificació serà G per a Guard (Base), F per a Forward (Alero), C per a Center (Pívot). 

Cal tenir present que un jugador pot jugar a més d’una posició i que, en aquest cas, cada posició estarà separada per un guió. 

La sortida en aquest cas també ha d’aparèixer amb un guió separador. 
També cal tenir present que ens podem trobar espais en blanc a la cadena d’entrada. 

Per exemple: 
Entrada: “G” ens donará: “Base”
*/



create or replace function posicioToString_pruebas
(numeroSucio varchar2) 
return varchar2 
is
  numeroLimpio varchar2(50);
  numeroSucioTamany number;
  var VARCHAR2(1000);

BEGIN

  numeroSucioTamany := length(numeroSucio);

  for i in 1..numeroSucioTamany LOOP

    var := substr(numeroSucio,i,1);

    if var = 'G' then
    	numeroLimpio:=(numeroLimpio|| 'Base ');
    end if;

    if var = 'F' then
    	numeroLimpio:=(numeroLimpio|| 'Alero ');
    end if;

    if var = 'C' then
    	numeroLimpio:=(numeroLimpio|| 'Pivot ');
    end if;  


  end loop;

  return numeroLimpio;
END;
/


CREATE OR REPLACE FUNCTION posicioToString(p_posicio IN VARCHAR2) 
RETURN VARCHAR2 
IS
    v_posicions VARCHAR2(30) := ' ';
    v_posicio_larga VARCHAR2(50) := ' ';
BEGIN
    SELECT ' '|| REPLACE(p_posicio, '-', ' ') ||' ' INTO v_posicions FROM dual;

    SELECT CASE 
               WHEN INSTR(v_posicions,' G ') > 0 THEN 'Base'
               ELSE '' END 
               ||
               CASE 
               WHEN INSTR(v_posicions,' F ') > 0 THEN '-Alero'
               ELSE '' END 
               ||
               CASE 
               WHEN INSTR(v_posicions,' C ') > 0 THEN '-Pivot'
               ELSE '' END 
               INTO v_posicio_larga FROM dual;
    
    RETURN TRIM(BOTH '-' FROM v_posicio_larga);
END;
/



/*
BEGIN
    dbms_output.put_line(posicioToString('G-F-Y-C'));
end;
*/