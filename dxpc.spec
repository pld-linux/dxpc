Summary:	dxpc - The Differential X Protocol Compressor
Name:		dxpc
Version:	3.7.0
Release:	1
Group:		X11/Applications/Networking
Copyright:	Distributable provided copyright and permission notices are included
URL:		http://ccwf.cc.utexas.edu/~zvonler/dxpc/
Source:		http://ccwf.cc.utexas.edu/~zvonler/dxpc/%{name}-%{version}.tar.gz
Patch0:		dxpc-DESTDIR.patch
Patch1:		dxpc-socklen_t.patch
Icon:		dxpc.logo-smaller-t.gif
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%define		_prefix		/usr/X11R6
%define		_mandir		%{_prefix}/man

%description
dxpc is an X protocol compressor designed to improve the
speed of X11 applications run over low-bandwidth links.

%prep 
%setup -q
%patch0 -p1
%patch1 -p1

%build
%configure
make

%install
make install DESTDIR=$RPM_BUILD_ROOT

strip --strip-unneeded $RPM_BUILD_ROOT%{_bindir}/*

gzip -9nf CHANGES README TODO dxpc-3.7.0.lsm \
	$RPM_BUILD_ROOT%{_mandir}/man1/*

%files
%defattr(644,root,root,755)
%doc CHANGES.gz README.gz TODO.gz dxpc-3.7.0.lsm.gz
%doc dxpc.logo.jpg dxpc.logo-small.jpg
%attr(755,root,root) %{_bindir}/dxpc
%{_mandir}/man1/dxpc.1*
