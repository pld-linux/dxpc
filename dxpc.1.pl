.\" {PTM/RM//31-08-2000}
.\" Autor troche miesza w konwencji nazw klient|klient proxy|serwer|Serwer proxy
.TH DXPC 1 "19 sierpnia 1999" "dxpc"
.ad b
.SH NAZWA
\fBdxpc\fR - r�nicowy kompresor protoko�u X

.SH WERSJA
3.8.0

.SH SK�ADNIA
.BR dxpc
\fB[wsp�lne] [klient | serwer] [po��czenie]\fR
.br

\fB[wsp�lne]\fR opcje:
.br
	-p \fInumer_portu\fR -f -k -v -s \fIpoziom_debugowania\fR -l \fIlog_file\fR
.br

\fB[klient]\fR opcje (dla procesu KLIENT-a):
.br
	-i \fIpoziom_kopresji\fR -d \fInumer_dispalya\fR -u
.br

\fB[serwer]\fR opcje (dla procesu SERWER-a):
.br
	-D \fIdisplay\fR
.br

\fB[po��czenie]\fR opcje:
.br
	\fInazwa_hosta\fR -w
.SH OPIS
\fBdxpc\fR jest kompresorem protoko�u X stworzonym w celu zwi�kszenia
szybko�ci "transmisji" aplikacji X11 uruchamianych przez wolne ��cza (np.: 
telefoniczne po��czenia PPP).
.sp
\fBdxpc\fR musi by� uruchomiony po obu stronach ��cza. Na jednym z host�w - 
gdzie pracuje rzeczywisty X serwer - \fBdxpc\fR pracuje w trybie "serwera proxy",
na drugim w trybie "klienta proxy". "Klient proxy" musi by� uruchomiony 
jako pierwszy. W czasie startu "serwer proxy" nawi�zuje po��czenie 
z "klientem". (Zauwa�, �e wersje \fBdxpc\fR sprzed 3.3.1 u�ywaj� odwrotnej
konwencji.) Kiedy jeden z proces�w \fBdxpc\fR jest przerywany, drugi 
automatycznie wy��cza si� r�wnie�.
.sp
"Klient proxy" na�laduje X-serwer. Aplikacje X-klienta ��cz� sie 
z "klientem proxy" u�ywaj�c displaya "unix:8" (lub <nazwa_hosta>:8 ;
\fBdxpc\fR wspomaga zar�wno domeny UNIX-owe jak i gniazda TCP). "Klient
proxy" przechwytuje wywo�ania X-owe od aplikacji, kompresuje je
i wysy�a do "serwera proxy". "Serwer" dekompresuje je i przesy�a
do rzeczywistego serwera X. Podobnie "serwer proxy" otrzymuje
zdarzenia, odpowiedzi i b��dy od rzeczywistego X-serwera, kompresuje
i przesy�a do "klienta proxy", kt�ry po dekompresji �le je do
aplikacji klienta.
.sp
Stopie� kompresji \fBdxpc\fR zale�y od typu aplikacji X-owej. Dla wi�kszo�ci
aplikacji \fBdxpc\fR uzyskuje wyniki kompresji od 3:1 do 6:1.
.sp
.SH MODY PRACY
\fBdxpc\fR mo�e pracowa� w jednym z dw�ch stan�w: stanie 
nawi�zywania po��czenia (\fInas�uchiwanie\fR lub \fI��czenie\fR) 
i stanie pracy w Systemie X (\fIklient\fR lub \fIserwer\fR). Ka�da sesja 
pracy w \fBdxpc\fR zawsze zaczyna sie od stanu nawi�zywnia po��czenia
po czym - je�eli po��czenie jest nawi�zane - przechodzi do stanu
pracy w Systemie X.
.sp
\fINas�uchiwanie\fR oczekuje na inicjacj� po��czenia TCP - mi�dzy 
dwoma procesami - przez \fI��czenie\fR. \fINas�uchiwanie\fR musi by�
zawsze uruchamiane jako pierwsze. \fI��czenie\fR jest inicjatorem po��czenie 
TCP
z \fInas�uchiwaniem\fR. \fBdxpc\fR startuje w trybie \fI��czenia\fR je�eli
podany jest argument \fInazwa_hosta\fR (zobacz: opcje \fBpo��czenie\fR, powy�ej).
W innym przypadku startuje w trybie \fInas�uchiwania\fR.
.sp
Proces \fIserwera\fR jest zwykle umiejscowiony na tej samej maszynie,
na kt�rej pracuje rzeczywisty X-serwer i odpowiada za wy�wietlanie
aplikacji, proces \fIklienta\fR
za� na maszynie, gdzie jest uruchomiona aplikacja X i odpowiada on za
przekazywanie wyniku pracy aplikacji do procesu \fIserwera\fR.
Domy�lna kolejno�� pracy \fBdxpc\fR jest nast�pujaca: tryb \fInas�uchiwania\fR,
a po zestawieniu po��czenia tryb \fIklienta\fR (je�eli nie u�yto argumentu 
\fInazwa_hosta\fR)
lub tryb \fI��czenia\fR, a po po��czeniu tryb \fIserwera\fR. Opcja -w
zmienia ta kolejno�� (tj.: \fInas�uchiwanie\fR-\fIserwer\fR lub 
\fI��czenie\fR-\fIklient\fR).
.sp
Na przyk�ad komenda \fBdxpc host.w_pracy.com\fR startuje \fBdxpc\fR w trybie
\fI��czenia\fR (poniewa� jest u�yty argument \fInazwa_hosta\fR)
i potem \fIserwera\fR (bo opcja -w nie zostala u�yta).
Komenda \fBdxpc -w\fR startuje \fBdxpc\fR w trybie \fInas�uchiwania\fR
(bo nie ma argumentu \fInazwa_hosta\fR) i potem \fIserwera\fR
(bo opcja -w zmienia standardowe wywolanie)
.sp
.SH Opcje
.TP 12
.B -d \fInumer_displaya\fR
Ustawia numer displaya, kt�ry \fBdxpc\fR imituje. Domy�lnie \fBdxpc\fR przyjmuje
warto�� 8 (opcja ignorowna w trybie "serwer proxy").

.TP 12
.B -f
Powoduje powielenie si� (forkowanie) \fBdxpc\fR i start jako daemon. Drukowanie 
komunikat�w na wyj�cie standardowe (poza b��dami) jest wstrzymane, statystyki
r�wnie�.
Proces daemona mo�e by� wy��czony przez (kolejne) u�ycie \fBdxpc\fR z opcj� \
fB-k\fR.

.TP 12
.B -k
Powoduje przeczytanie numeru PID z pliku blokuj�cego w katalogu domowym
u�ytkownika (~/.dxpc.pid-HOST-USER-PORT) i przes�anie sygna�u SIGKILL do 
pracuj�cego procesu \fBdxpc\fR. Plik blokuj�cy istnieje jedynie je�eli
\fBdxpc\fR zosta�o uruchomione z opcja \fB-f\fR.

.TP 12
.B -l \fIlog_file\fR
Z t� opcj� \fBdxpc\fR zapisuje komunikaty i informacje statystyczne do 
pliku dziennika \fIlog_file\fR.
Opcja szczeg�lnie u�yteczna z \fB-f\fR.

.TP 12
.B -p \fInumer_portu\fR
Ta opcja ustawia port TCP, kt�ry b�dzie u�ywany do komunikacji mi�dzy
"klientem proxy" i "serwerem proxy". Warto�� domy�lna 4000.

.TP 12
.B -s(1|2)
Wy�wietla raport o poziomie kompresji. W trybie "klienta proxy" \fBdxpc\fR
wypisuje raport o kompresji na podstawie komunikat�w od X-klienta,
w trybie "serwera proxy" na podstawie komunikat�w X-serwera.
Z opcj� \fB-s1\fR \fBdxpc\fR informuje o poziomie kompresji w postaci
skr�conej, z \fB-s2\fR w postaci szczeg�owej. Wi�kszo�ci u�ytkownik�w
z pewno�ci� wystarczy opcja \fB-s1\fR.

.TP 12
.B "-u -t"
Normalnie \fBdxpc\fR w trybie "klienta proxy" imituje display :8 (zar�wno
w przypadku gniazd TCP jak i domen UNIX-owych). Opcja \fB-u\fR
zabrania \fBdxpc\fR u�ywania domen UNIX-owych, a \fB-t\fR gniazd TCP.
(Opcje s� ignorowane w trybie "serwer proxy").

.TP 12
.B "-v"
\fBdxpc\fR z opcj� \fB-v\fR wypisuje numer wersji, informacje o prawach autorskich
i ko�czy prac�.

.TP 12
.B "-w"
Odwraca kolejno�� "sluchania" i "inicjowania" w stanie nawi�zywania po��czenia.
Oznacza to, �e klient b�dzie inicjowa� po��czenia z serwerem.
W miejsce komend uruchamiaj�cych: klienta \fBdxpc -f\fR i serwera
\fBdxpc -f serwer.w_pracy.com\fR mo�na u�y�: \fBdxpc -w -f serwer.w_domu.priv\fR
- start klienta i \fBdxpc -w -f\fR - start serwera. Opcja \fB-w\fR
jest u�yteczna dla startu "klienta proxy" za firewallem.

.TP 12
.B "nazwa_hosta"
Argument \fInazwa_hosta\fR musi by� u�yty w trybie "serwera proxy"
w celu identyfikacji maszyny (po nazwie b�d� po adresie IP), na kt�rej
uruchomiony jest \fBdxpc\fR w trybie "klienta proxy". (Obecno�� tego argumentu 
implikuje start w trybie "serwera proxy", jego brak w trybie "klienta proxy").

.TP 12
.B "-D display"
Ustawia (display) hosta, na kt�ry przesy�ane b�d� aplikacje X.
Domy�lnie jest to zmienna �rodowiska DISPLAY. 

.TP 12
.B "-i(0..9|99|999)"
Kontrola kompresji bitmap. (Opcja \fB-i\fR mo�e by� u�ywana na kliencie albo
- je�eli podano opcje \fB-w\fR - na serwerze, w pozosta�ych przypadkach jest
ignorowana.) Numer odpowiada za poziom kompresji; wy�sze poziomy daj� lepsz�
kompresj� ale kosztem CPU i pami�ci (g��wnie na "kliencie proxy").
Aktulna lista poziom�w i typ�w kompresji jest podana ponizej.

0 : Bez kompresji (opr�cz \fBdxpc\fR 3.7.0, gdzie daje bardzo s�ab� kompresj�).

1 : kompresja LZO lzo1x_1; bardzo szybka, ma�e zu�ycie CPU, rozs�dny poziom
kompresji.

2-9: kompresja LZO wariant lzo1c_n . lzo1c_2 wydaje sie by� gorsza ni� lzo1x_1.

99: kompresja LZO lzo1c_99. Wolna ale bardzo dobra kompresja. Zanotowano
niespodziewane b��dy. Nie zalecana.

999: kompresja LZO lzo1x_999. Wolna (ale wystarczaj�co szybka dla po��cze� 
128k ISDN, przy korzystaniu z Pentium II/300 nie u�ywa - nawet chwilowo - pe�nej mocy
procesora). Warto�� domy�lna i zalecana.


.SH PRZYK�ADY
W przypadku u�ycia rzeczywistego X-serwera na lokalnej maszynie (pc_w_domu)
i korzystania z aplikacji na zdalnym systemie (serwer.praca.com) wy�wietlanych
na lokalnej maszynie. 
.sp
Na zdalnej maszynie serwer.praca.com 
.nf
    $ export DISPLAY=pc_w_domu:0 (sh lub bash)
lub $ setenv DISPLAY pc_w_domu:0 (csh lub tcsh)
    $ \fBdxpc\fR -f
    $ export DISPLAY=unix:8      (sh lub bash)
lub $ setenv DISPLAY unix:8      (csh lub tcsh)
.fi

Na lokalnej maszynie
.nf
    $ export DISPLAY=unix:0      (sh lub bash)
lub $ setenv DISPLAY unix:0      (csh lub tcsh)
    $ \fBdxpc\fR -f serwer.praca.com
.fi

Teraz zn�w na zdalnej maszynie
.nf
    $ xterm&
    $ xemacs&
    itd...
.fi

.SH "DXPC I XAUTH"
Je�eli u�ywasz autoryzacji X z plikiem .Xauthority na lokalnej maszynie,
gdzie pracuje rzeczywisty X-serwer powiniene� dostosowa� plik .Xauthority 
na maszynie, gdzie \fBdxpc\fR jest uruchomione w trybie "klienta proxy".
Jedn� z dr�g do tego prowadz�cych jest: 
 .sp
Skopiowanie pliku ~/.Xauthority z lokalnej maszyny na zdaln� (gdzie
jest "klient proxy").
 .sp
Wydanie polecenia
.nf
    $ \fBxauth\fR list
.fi
w celu obejrzenia kluczy autoryzacyjnych. Jedna z linijek
w wydruku powinna zawiera� Tw�j display X i wygl�da� podobnie do:
.nf
    <Twoj_host>/unix:0   MIT-MAGIC-COOKIE-1   <HEX>
.fi
Na maszynie, na kt�rej pracuje "klient proxy" nale�y "doda�" t� lini�
do pliku .Xauthority, ale z "oszukanym" X-displayem (DISPLAY
z serwera, gdzie "klient proxy" nas�uchuje). Opcja "add"
komendy \fBxauth\fR realizuje to nast�puj�co
.nf
    $ \fBxauth\fR add <host>/unix:8 MIT-MAGIC-COOKIE-1  <HEX>
.fi
gdzie <host> jest nazw� maszyny, gdzie jest uruchomiony "klient proxy".
Po wykonaniu tego polecenia powinno by� mo�liwe bezproblemowe u�ywanie \fBdxpc\fR.
.sp
Uwaga: W przypadku po��cze� przez slogin (ssh) wydruk z komendy
.nf
    $ \fBxauth\fR list
.fi
mo�e by� inny. Warto przed podaniem w/w komendy skorzysta� z
.nf
    $ echo $DISPLAY
.fi

.SH AUTOR
Brian Pane

.SH POMOC
Kevin Vigor (kevin@vigor.nu)

.SH PODZI�KOWANIA
\fBdxpc\fR zaadoptowa�o wiele koncepcji z systemu \fBHBX\fR i \fBFHBX\fR
 (http://www.cs.dartmouth.edu/~jmd/decs/DECSpage.html).
.sp
Dziekuj� wszystkim u�ytkownikom, kt�rzy przesy�ali sugestie i uwagi.

.SH ZOBACZ TAK�E
xauth(1), plik README z dytrybucji dxpc.

.SH OD T�UMACZA
Dodano kilka s��w w sekcji \fBPRZYK�ADY\fR.
