.\" {PTM/RM//31-08-2000}
.\" Autor troche miesza w konwencji nazw klient|klient proxy|serwer|Serwer proxy
.TH DXPC 1 "19 sierpnia 1999" "dxpc"
.ad b
.SH NAZWA
\fBdxpc\fR - ró¿nicowy kompresor protoko³u X

.SH WERSJA
3.8.0

.SH SK£ADNIA
.BR dxpc
\fB[wspólne] [klient | serwer] [po³±czenie]\fR
.br

\fB[wspólne]\fR opcje:
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

\fB[po³±czenie]\fR opcje:
.br
	\fInazwa_hosta\fR -w
.SH OPIS
\fBdxpc\fR jest kompresorem protoko³u X stworzonym w celu zwiêkszenia
szybko¶ci "transmisji" aplikacji X11 uruchamianych przez wolne ³±cza (np.: 
telefoniczne po³±czenia PPP).
.sp
\fBdxpc\fR musi byæ uruchomiony po obu stronach ³±cza. Na jednym z hostów - 
gdzie pracuje rzeczywisty X serwer - \fBdxpc\fR pracuje w trybie "serwera proxy",
na drugim w trybie "klienta proxy". "Klient proxy" musi byæ uruchomiony 
jako pierwszy. W czasie startu "serwer proxy" nawi±zuje po³±czenie 
z "klientem". (Zauwa¿, ¿e wersje \fBdxpc\fR sprzed 3.3.1 u¿ywaj± odwrotnej
konwencji.) Kiedy jeden z procesów \fBdxpc\fR jest przerywany, drugi 
automatycznie wy³±cza siê równie¿.
.sp
"Klient proxy" na¶laduje X-serwer. Aplikacje X-klienta ³±cz± sie 
z "klientem proxy" u¿ywaj±c displaya "unix:8" (lub <nazwa_hosta>:8 ;
\fBdxpc\fR wspomaga zarówno domeny UNIX-owe jak i gniazda TCP). "Klient
proxy" przechwytuje wywo³ania X-owe od aplikacji, kompresuje je
i wysy³a do "serwera proxy". "Serwer" dekompresuje je i przesy³a
do rzeczywistego serwera X. Podobnie "serwer proxy" otrzymuje
zdarzenia, odpowiedzi i b³êdy od rzeczywistego X-serwera, kompresuje
i przesy³a do "klienta proxy", który po dekompresji ¶le je do
aplikacji klienta.
.sp
Stopieñ kompresji \fBdxpc\fR zale¿y od typu aplikacji X-owej. Dla wiêkszo¶ci
aplikacji \fBdxpc\fR uzyskuje wyniki kompresji od 3:1 do 6:1.
.sp
.SH MODY PRACY
\fBdxpc\fR mo¿e pracowaæ w jednym z dwóch stanów: stanie 
nawi±zywania po³±czenia (\fInas³uchiwanie\fR lub \fI³±czenie\fR) 
i stanie pracy w Systemie X (\fIklient\fR lub \fIserwer\fR). Ka¿da sesja 
pracy w \fBdxpc\fR zawsze zaczyna sie od stanu nawi±zywnia po³±czenia
po czym - je¿eli po³±czenie jest nawi±zane - przechodzi do stanu
pracy w Systemie X.
.sp
\fINas³uchiwanie\fR oczekuje na inicjacjê po³±czenia TCP - miêdzy 
dwoma procesami - przez \fI³±czenie\fR. \fINas³uchiwanie\fR musi byæ
zawsze uruchamiane jako pierwsze. \fI£±czenie\fR jest inicjatorem po³±czenie 
TCP
z \fInas³uchiwaniem\fR. \fBdxpc\fR startuje w trybie \fI³±czenia\fR je¿eli
podany jest argument \fInazwa_hosta\fR (zobacz: opcje \fBpo³±czenie\fR, powy¿ej).
W innym przypadku startuje w trybie \fInas³uchiwania\fR.
.sp
Proces \fIserwera\fR jest zwykle umiejscowiony na tej samej maszynie,
na której pracuje rzeczywisty X-serwer i odpowiada za wy¶wietlanie
aplikacji, proces \fIklienta\fR
za¶ na maszynie, gdzie jest uruchomiona aplikacja X i odpowiada on za
przekazywanie wyniku pracy aplikacji do procesu \fIserwera\fR.
Domy¶lna kolejno¶æ pracy \fBdxpc\fR jest nastêpujaca: tryb \fInas³uchiwania\fR,
a po zestawieniu po³±czenia tryb \fIklienta\fR (je¿eli nie u¿yto argumentu 
\fInazwa_hosta\fR)
lub tryb \fI³±czenia\fR, a po po³±czeniu tryb \fIserwera\fR. Opcja -w
zmienia ta kolejno¶æ (tj.: \fInas³uchiwanie\fR-\fIserwer\fR lub 
\fI³±czenie\fR-\fIklient\fR).
.sp
Na przyk³ad komenda \fBdxpc host.w_pracy.com\fR startuje \fBdxpc\fR w trybie
\fI³±czenia\fR (poniewa¿ jest u¿yty argument \fInazwa_hosta\fR)
i potem \fIserwera\fR (bo opcja -w nie zostala u¿yta).
Komenda \fBdxpc -w\fR startuje \fBdxpc\fR w trybie \fInas³uchiwania\fR
(bo nie ma argumentu \fInazwa_hosta\fR) i potem \fIserwera\fR
(bo opcja -w zmienia standardowe wywolanie)
.sp
.SH Opcje
.TP 12
.B -d \fInumer_displaya\fR
Ustawia numer displaya, który \fBdxpc\fR imituje. Domy¶lnie \fBdxpc\fR przyjmuje
warto¶æ 8 (opcja ignorowna w trybie "serwer proxy").

.TP 12
.B -f
Powoduje powielenie siê (forkowanie) \fBdxpc\fR i start jako daemon. Drukowanie 
komunikatów na wyj¶cie standardowe (poza b³êdami) jest wstrzymane, statystyki
równie¿.
Proces daemona mo¿e byæ wy³±czony przez (kolejne) u¿ycie \fBdxpc\fR z opcj± \
fB-k\fR.

.TP 12
.B -k
Powoduje przeczytanie numeru PID z pliku blokuj±cego w katalogu domowym
u¿ytkownika (~/.dxpc.pid-HOST-USER-PORT) i przes³anie sygna³u SIGKILL do 
pracuj±cego procesu \fBdxpc\fR. Plik blokuj±cy istnieje jedynie je¿eli
\fBdxpc\fR zosta³o uruchomione z opcja \fB-f\fR.

.TP 12
.B -l \fIlog_file\fR
Z t± opcj± \fBdxpc\fR zapisuje komunikaty i informacje statystyczne do 
pliku dziennika \fIlog_file\fR.
Opcja szczególnie u¿yteczna z \fB-f\fR.

.TP 12
.B -p \fInumer_portu\fR
Ta opcja ustawia port TCP, który bêdzie u¿ywany do komunikacji miêdzy
"klientem proxy" i "serwerem proxy". Warto¶æ domy¶lna 4000.

.TP 12
.B -s(1|2)
Wy¶wietla raport o poziomie kompresji. W trybie "klienta proxy" \fBdxpc\fR
wypisuje raport o kompresji na podstawie komunikatów od X-klienta,
w trybie "serwera proxy" na podstawie komunikatów X-serwera.
Z opcj± \fB-s1\fR \fBdxpc\fR informuje o poziomie kompresji w postaci
skróconej, z \fB-s2\fR w postaci szczegó³owej. Wiêkszo¶ci u¿ytkowników
z pewno¶ci± wystarczy opcja \fB-s1\fR.

.TP 12
.B "-u -t"
Normalnie \fBdxpc\fR w trybie "klienta proxy" imituje display :8 (zarówno
w przypadku gniazd TCP jak i domen UNIX-owych). Opcja \fB-u\fR
zabrania \fBdxpc\fR u¿ywania domen UNIX-owych, a \fB-t\fR gniazd TCP.
(Opcje s± ignorowane w trybie "serwer proxy").

.TP 12
.B "-v"
\fBdxpc\fR z opcj± \fB-v\fR wypisuje numer wersji, informacje o prawach autorskich
i koñczy pracê.

.TP 12
.B "-w"
Odwraca kolejno¶æ "sluchania" i "inicjowania" w stanie nawi±zywania po³±czenia.
Oznacza to, ¿e klient bêdzie inicjowa³ po³±czenia z serwerem.
W miejsce komend uruchamiaj±cych: klienta \fBdxpc -f\fR i serwera
\fBdxpc -f serwer.w_pracy.com\fR mo¿na u¿yæ: \fBdxpc -w -f serwer.w_domu.priv\fR
- start klienta i \fBdxpc -w -f\fR - start serwera. Opcja \fB-w\fR
jest u¿yteczna dla startu "klienta proxy" za firewallem.

.TP 12
.B "nazwa_hosta"
Argument \fInazwa_hosta\fR musi byæ u¿yty w trybie "serwera proxy"
w celu identyfikacji maszyny (po nazwie b±d¼ po adresie IP), na której
uruchomiony jest \fBdxpc\fR w trybie "klienta proxy". (Obecno¶æ tego argumentu 
implikuje start w trybie "serwera proxy", jego brak w trybie "klienta proxy").

.TP 12
.B "-D display"
Ustawia (display) hosta, na który przesy³ane bêd± aplikacje X.
Domy¶lnie jest to zmienna ¶rodowiska DISPLAY. 

.TP 12
.B "-i(0..9|99|999)"
Kontrola kompresji bitmap. (Opcja \fB-i\fR mo¿e byæ u¿ywana na kliencie albo
- je¿eli podano opcje \fB-w\fR - na serwerze, w pozosta³ych przypadkach jest
ignorowana.) Numer odpowiada za poziom kompresji; wy¿sze poziomy daj± lepsz±
kompresjê ale kosztem CPU i pamiêci (g³ównie na "kliencie proxy").
Aktulna lista poziomów i typów kompresji jest podana ponizej.

0 : Bez kompresji (oprócz \fBdxpc\fR 3.7.0, gdzie daje bardzo s³ab± kompresjê).

1 : kompresja LZO lzo1x_1; bardzo szybka, ma³e zu¿ycie CPU, rozs±dny poziom
kompresji.

2-9: kompresja LZO wariant lzo1c_n . lzo1c_2 wydaje sie byæ gorsza ni¿ lzo1x_1.

99: kompresja LZO lzo1c_99. Wolna ale bardzo dobra kompresja. Zanotowano
niespodziewane b³êdy. Nie zalecana.

999: kompresja LZO lzo1x_999. Wolna (ale wystarczaj±co szybka dla po³±czeñ 
128k ISDN, przy korzystaniu z Pentium II/300 nie u¿ywa - nawet chwilowo - pe³nej mocy
procesora). Warto¶æ domy¶lna i zalecana.


.SH PRZYK£ADY
W przypadku u¿ycia rzeczywistego X-serwera na lokalnej maszynie (pc_w_domu)
i korzystania z aplikacji na zdalnym systemie (serwer.praca.com) wy¶wietlanych
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

Teraz znów na zdalnej maszynie
.nf
    $ xterm&
    $ xemacs&
    itd...
.fi

.SH "DXPC I XAUTH"
Je¿eli u¿ywasz autoryzacji X z plikiem .Xauthority na lokalnej maszynie,
gdzie pracuje rzeczywisty X-serwer powiniene¶ dostosowaæ plik .Xauthority 
na maszynie, gdzie \fBdxpc\fR jest uruchomione w trybie "klienta proxy".
Jedn± z dróg do tego prowadz±cych jest: 
 .sp
Skopiowanie pliku ~/.Xauthority z lokalnej maszyny na zdaln± (gdzie
jest "klient proxy").
 .sp
Wydanie polecenia
.nf
    $ \fBxauth\fR list
.fi
w celu obejrzenia kluczy autoryzacyjnych. Jedna z linijek
w wydruku powinna zawieraæ Twój display X i wygl±daæ podobnie do:
.nf
    <Twoj_host>/unix:0   MIT-MAGIC-COOKIE-1   <HEX>
.fi
Na maszynie, na której pracuje "klient proxy" nale¿y "dodaæ" tê liniê
do pliku .Xauthority, ale z "oszukanym" X-displayem (DISPLAY
z serwera, gdzie "klient proxy" nas³uchuje). Opcja "add"
komendy \fBxauth\fR realizuje to nastêpuj±co
.nf
    $ \fBxauth\fR add <host>/unix:8 MIT-MAGIC-COOKIE-1  <HEX>
.fi
gdzie <host> jest nazw± maszyny, gdzie jest uruchomiony "klient proxy".
Po wykonaniu tego polecenia powinno byæ mo¿liwe bezproblemowe u¿ywanie \fBdxpc\fR.
.sp
Uwaga: W przypadku po³±czeñ przez slogin (ssh) wydruk z komendy
.nf
    $ \fBxauth\fR list
.fi
mo¿e byæ inny. Warto przed podaniem w/w komendy skorzystaæ z
.nf
    $ echo $DISPLAY
.fi

.SH AUTOR
Brian Pane

.SH POMOC
Kevin Vigor (kevin@vigor.nu)

.SH PODZIÊKOWANIA
\fBdxpc\fR zaadoptowa³o wiele koncepcji z systemu \fBHBX\fR i \fBFHBX\fR
 (http://www.cs.dartmouth.edu/~jmd/decs/DECSpage.html).
.sp
Dziekujê wszystkim u¿ytkownikom, którzy przesy³ali sugestie i uwagi.

.SH ZOBACZ TAK¯E
xauth(1), plik README z dytrybucji dxpc.

.SH OD T£UMACZA
Dodano kilka s³ów w sekcji \fBPRZYK£ADY\fR.
