Summary:	dxpc - The Differential X Protocol Compressor
Summary(pl):	Ró¿nicowy kompresor X protoko³u
Name:		dxpc
Version:	3.7.0
Release:	3
License:	distributable provided copyright and permission notices are included
Group:		X11/Applications/Networking
Source0:	http://ccwf.cc.utexas.edu/~zvonler/dxpc/%{name}-%{version}.tar.gz
Source1:	%{name}.1.pl
Patch0:		%{name}-DESTDIR.patch
Patch1:		%{name}-socklen_t.patch
Patch2:		%{name}-ac_lt.patch
URL:		http://ccwf.cc.utexas.edu/~zvonler/dxpc/
Icon:		dxpc.logo-smaller-t.gif
BuildRequires:	autoconf
BuildRequires:	automake
BuildRequires:	libstdc++-devel
BuildRequires:	libtool
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%define		_prefix		/usr/X11R6
%define		_mandir		%{_prefix}/man

%description
dxpc is an X protocol compressor designed to improve the speed of X11
applications run over low-bandwidth links.

%description -l pl
dxpc jest kompresorem X protoko³u zaprojektowanym dla zwiêkszenia
szybko¶ci dzia³ania aplikacji uruchamianych przez ³±cza o ma³ej
przepustowo¶ci.

%prep
%setup -q
%patch0 -p1
%patch1 -p1
%patch2 -p1

%build
%{__libtoolize}
%{__aclocal}
%{__autoconf}
CXXFLAGS="%{rpmcflags} -fno-rtti -fno-exceptions -fno-implicit-templates"
%configure
%{__make}

%install
rm -rf $RPM_BUILD_ROOT

%{__make} install DESTDIR=$RPM_BUILD_ROOT

install -d $RPM_BUILD_ROOT%{_mandir}/pl/man1
install %{SOURCE1} $RPM_BUILD_ROOT%{_mandir}/pl/man1/dxpc.1

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc CHANGES README TODO
%doc dxpc.logo.jpg dxpc.logo-small.jpg
%attr(755,root,root) %{_bindir}/dxpc
%{_mandir}/man1/*
%lang(pl) %{_mandir}/pl/man1/*
