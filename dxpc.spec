Summary:	dxpc - The Differential X Protocol Compressor
Summary(pl):	Ró¿nicowy kompresor X protoko³u
Name:		dxpc
Version:	3.7.0
Release:	1
Group:		X11/Applications/Networking
Group(de):	X11/Applikationen/Netzwerkwesen
Group(pl):	X11/Aplikacje/Sieciowe
License:	Distributable provided copyright and permission notices are included
Source0:	http://ccwf.cc.utexas.edu/~zvonler/dxpc/%{name}-%{version}.tar.gz
Patch0:		%{name}-DESTDIR.patch
Patch1:		%{name}-socklen_t.patch
URL:		http://ccwf.cc.utexas.edu/~zvonler/dxpc/
Icon:		dxpc.logo-smaller-t.gif
BuildRequires:	libstdc++-devel
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%define		_prefix		/usr/X11R6
%define		_mandir		%{_prefix}/man

%description
dxpc is an X protocol compressor designed to improve the speed of X11
applications run over low-bandwidth links.

%prep 
%setup -q
%patch0 -p1
%patch1 -p1

%build
CXXFLAGS="%{rpmcflags} -fno-rtti -fno-exceptions"
%configure
make

%install
rm -rf $RPM_BUILD_ROOT

%{__make} install DESTDIR=$RPM_BUILD_ROOT

gzip -9nf CHANGES README TODO

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc *.gz
%doc dxpc.logo.jpg dxpc.logo-small.jpg
%attr(755,root,root) %{_bindir}/dxpc
%{_mandir}/man1/*
