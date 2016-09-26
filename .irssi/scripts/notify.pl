
use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
use HTML::Entities;
use Net::DBus;

$VERSION = "0.1";
%IRSSI = (
    authors     => 'Rodrigo Belem',
    contact     => '',
    name        => 'notify.pl',
    description => 'Use dbus notifications service to alert user',
    license     => 'GNU General Public License',
    url         => '',
);

Irssi::settings_add_str('notify', 'notify_icon', 'presence_online');
Irssi::settings_add_str('notify', 'notify_time', '5000');

my $APPNAME = 'irssi';

my $bus = Net::DBus->session;
my $notifications = $bus->get_service('org.freedesktop.Notifications');
my $object = $notifications->get_object('/org/freedesktop/Notifications',
                    'org.freedesktop.Notifications');

sub notify {
    my ($server, $type_description, $nick, $message) = @_;

    $object->Notify("${APPNAME}:${server}",
        0,
        'lifegame',
        "$type_description",
        "$nick: $message",
        [], { }, 3000);
}

sub message_public_notify {
    my ($dest, $text, $message) = @_;
    my $server = $dest->{server};

    return if (!$server || !($dest->{level} & MSGLEVEL_HILIGHT));
    my $nick = $message;
    $nick =~ s/^\<.([^\>]+)\>.+/\1/ ;
    $message =~ s/^\<.[^\>]+\>.// ;
    my $target = $dest->{target};
    notify($server, "Public Message in $target", $nick, $message);
}

sub message_private_notify {
    my ($server, $message, $nick, $address) = @_;

    return if (!$server);
    notify($server, "Private Message", $nick, $message);
}

sub dcc_request_notify {
    my ($dcc, $sendaddr) = @_;
    my $server = $dcc->{server};

    return if (!$dcc);
    notify($server, "DCC ".$dcc->{type}." request", $dcc->{nick}, $sendaddr);
}

Irssi::signal_add('message public', 'message_public_notify');
Irssi::signal_add('message private', 'message_private_notify');
Irssi::signal_add('dcc request', 'dcc_request_notify');
