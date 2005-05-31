Summary:	dxpc - The Differential X Protocol Compressor
Summary(pl):	Ró¿nicowy kompresor X protoko³u
Name:		dxpc
Version:	3.8.2
Release:	1
License:	distributable provided copyright and permission notices are included
Group:		X11/Applications/Networking
Source0:	http://www.vigor.nu/%{name}/%{version}/%{name}-%{version}.tar.gz
# Source0-md5:	3fbfb0e4bf769e64d27da331ecddbc9f
Source1:	%{name}.1.pl
Patch0:		%{name}-DESTDIR.patch
URL:		http://www.vigor.nu/dxpc/
Icon:		dxpc.logo-smaller-t.gif
BuildRequires:	XFree86-devel
BuildRequires:	autoconf
BuildRequires:	automake
BuildRequires:	libstdc++-devel
BuildRequires:	lzo-devel
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

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

%build
cp -f /usr/share/automake/config.* .
%{__aclocal}
%{__autoconf}
CXXFLAGS="%{rpmcflags} -fno-rtti -fno-exceptions -fno-implicit-templates"
%configure
%{__make}

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT%{_mandir}/pl/man1

%{__make} install \
	DESTDIR=$RPM_BUILD_ROOT

install %{SOURCE1} $RPM_BUILD_ROOT%{_mandir}/pl/man1/dxpc.1

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc CHANGES README TODO dxpc.logo.jpg dxpc.logo-small.jpg
%attr(755,root,root) %{_bindir}/dxpc
%{_mandir}/man1/*
%lang(pl) %{_mandir}/pl/man1/*
