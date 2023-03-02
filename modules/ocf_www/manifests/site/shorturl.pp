class ocf_www::site::shorturl {
  $canonical_url = $::host_env ? {
    'dev'  => 'https://dev-ocf-io.ocf.berkeley.edu/',
    'prod' => 'https://ocf.io/',
  }

  apache::vhost { 'shorturl':
    servername    => 'ocf.io',
    serveraliases => ['dev-ocf-io.ocf.berkeley.edu', 'www.ocf.io'],
    port          => 443,
    docroot       => '/var/www/html',

    ssl           => true,
    ssl_key       => "/etc/ssl/private/${::fqdn}.key",
    ssl_cert      => "/etc/ssl/private/${::fqdn}.crt",
    ssl_chain     => "/etc/ssl/private/${::fqdn}.intermediate",

    rewrites      => [
      # Short URLs
      # Remember to add these to the list of RESERVED_USERNAMES in ocflib/account/validators.py
      {rewrite_rule => '^/?$ https://www.ocf.berkeley.edu/ [R=301]'},
      {rewrite_rule => '^/about$ https://www.ocf.berkeley.edu/docs/about/ [R]'},
      {rewrite_rule => '^/absa$ https://drive.google.com/drive/folders/0B7n5VUVfGPUoV0xPREIwY0hzc0E?usp=sharing [R]'},
      {rewrite_rule => '^/account$ https://www.ocf.berkeley.edu/docs/services/account/ [R]'},
      {rewrite_rule => '^/accessibility$ https://docs.google.com/document/d/15_ZFfYG6yv0YNmPPKfbaCK4kPQpRnkCTfx7L9t3LiLE/edit#heading=h.y7iaxq6cdj4b [R]'},
      {rewrite_rule => '^/apphost$ https://www.ocf.berkeley.edu/docs/services/webapps/ [R]'},
      {rewrite_rule => '^/announce$ https://groups.google.com/a/lists.berkeley.edu/forum/#!forum/ocf/join [NE,R]'},
      {rewrite_rule => '^/apply$ https://forms.gle/ACnWLyaEpqgV1rP29 [R]'},
      {rewrite_rule => '^/apparel$ https://docs.google.com/forms/d/e/1FAIpQLSdJJeyRjkJhGVcH9frHtE6dtXHbgfD-fy9J5d2wRkzqSl5nPw/viewform [R]'},
      {rewrite_rule => '^/banquet$ https://forms.gle/z2d8H8K4VoJEq1hw5 [R]'},
      {rewrite_rule => '^/bjb$ https://jukebox.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/bod(/.*)?$ https://www.ocf.berkeley.edu/~staff/bod$1 [R]'},
      {rewrite_rule => '^/buy$ https://goo.gl/forms/PnlB5dJawGZcUS0S2 [R]'},
      {rewrite_rule => '^/buysheet$ https://docs.google.com/spreadsheets/d/16tMZGSrr3D6ao8V-cIyeE5PTEYf1XQEQ9rALGAjoWls/edit?usp=sharing [R]'},
      {rewrite_rule => '^/callinkapi(.*)?$ https://studentgroupservice.sait-west.berkeley.edu/service.asmx$1 [R]'},
      {rewrite_rule => '^/cockroachdb$ https://cockroachlabs.zoom.us/j/95104416835 [R]'},
      {rewrite_rule => '^/cockroachdb-rsvp$ https://docs.google.com/forms/d/e/1FAIpQLSduHSz5Q66gWH7a2vfBM3rpDqbabrGtxWCuaQNR_C4Q8_J6Cw/viewform?usp=sf_link [R]'},
      {rewrite_rule => '^/contact$ https://www.ocf.berkeley.edu/docs/contact/ [R]'},
      {rewrite_rule => '^/coffeechats$ https://docs.google.com/spreadsheets/d/1_xACT5YKjBi1W-mZjKo6YdkfTQinzcPG5iOXrWgs72E/edit [R]'},
      {rewrite_rule => '^/committee$ https://docs.google.com/spreadsheets/d/17vjngK4aMUDdLtRGaGNap3fmTwxbP3D3QJKrwZz7uk4/edit#gid=0 [R]'},
      {rewrite_rule => '^/d$ https://discourse.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/d/([0-9]+)$ https://discourse.ocf.berkeley.edu/t/$1 [R]'},
      {rewrite_rule => '^/decal(/.*)?$ https://decal.ocf.berkeley.edu$1 [R]'},
      {rewrite_rule => '^/decalinfo$ https://docs.google.com/presentation/d/16MkYo0svCWT9O2BrWAD1Ny8vtH4OKxjKwKGq2gGaqQc/ [R]'},
      {rewrite_rule => '^/decalzoom$ https://berkeley.zoom.us/j/94285257750?pwd=OGx1TUlKWmNrQnNwdkxwRTlSL2VTUT09 [R]'},
      {rewrite_rule => '^/desktopstats$ https://grafana.ocf.berkeley.edu/d/-VCUTE8Zk/desktops?orgId=1&refresh=10s [R]'},
      {rewrite_rule => '^/discord$ https://discord.gg/mwhu5eh [R]'},
      {rewrite_rule => '^/docs(/.*)?$ https://www.ocf.berkeley.edu/docs$1 [R]'},
      {rewrite_rule => '^/donate$ https://give.berkeley.edu/egiving/index.cfm?fund=FU1450000&org=Open+Computing+Facility&amt=&fundlist=FU1450000 [R]'},
      {rewrite_rule => '^/email-update$ https://status.ocf.berkeley.edu/2014/06/email-discontinuation-update-forward.html [R]'},
      {rewrite_rule => '^/eligibility$ https://www.ocf.berkeley.edu/docs/membership/eligibility/ [R]'},
      {rewrite_rule => '^/families$ https://docs.google.com/presentation/d/1y49eQj-SPIsMtIio2KFx86SF6tKcv1yB16pO6AS2uk4/edit [R]'},
      {rewrite_rule => '^/faq$ https://www.ocf.berkeley.edu/docs/faq/ [R]'},
      {rewrite_rule => '^/gh/([^/]*)(/(?!blob/)(?!tree/)(?!info/)(?!issue)(?!pull)(?!search).+)$ https://ocf.io/gh/$1/blob/master$2 [R]'},
      {rewrite_rule => '^/gh/i(/.*)?$ https://github.com/ocf/ircbot$1 [R]'},
      {rewrite_rule => '^/gh/l(/.*)?$ https://github.com/ocf/ocflib$1 [R]'},
      {rewrite_rule => '^/gh/p(/.*)?$ https://github.com/ocf/puppet$1 [R]'},
      {rewrite_rule => '^/gh/u(/.*)?$ https://github.com/ocf/utils$1 [R]'},
      {rewrite_rule => '^/gh/w(/.*)?$ https://github.com/ocf/ocfweb$1 [R]'},
      {rewrite_rule => '^/gh(/.*)?$ https://ocf.io/github$1 [R]'},
      {rewrite_rule => '^/github(/.*)?$ https://github.com/ocf$1 [R]'},
      {rewrite_rule => '^/gadmin$ https://admin.google.com/a/ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/gcal$ https://calendar.google.com/a/ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/get(ing)?involved$ https://www.ocf.berkeley.edu/docs/staff/getinvolved/ [R]'},
      {rewrite_rule => '^/gcal/ocf$ https://calendar.google.com/calendar/embed?src=ocf.berkeley.edu_bcl2puplt6t9e9e9njme6jqca8@group.calendar.google.com&ctz=America/Los_Angeles [R]'},
      {rewrite_rule => '^/gcal/officers$ https://calendar.google.com/calendar/embed?src=ocf.berkeley.edu_3e56a1lm5gnd91vf1r7fafi7u4@group.calendar.google.com&ctz=America/Los_Angeles [R]'},
      {rewrite_rule => '^/gettoknow$ https://forms.gle/i3M1XXsFmwwy633h9 [R]'},
      {rewrite_rule => '^/gmail$ https://mail.google.com/a/ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/gdrive$ https://drive.google.com/a/ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/gdrive/staff$ https://drive.google.com/drive/folders/0AKXh7iBur_mbUk9PVA [R]'},
      {rewrite_rule => '^/gdrive/officers$ https://drive.google.com/drive/folders/0APZdR8kE4NN1Uk9PVA [R]'},
      {rewrite_rule => '^/guest$ https://goo.gl/forms/ImNfnZkrRrakZcIr1 [R]'},
      {rewrite_rule => '^/halloween$ https://forms.gle/44kTL8Eo9Tr3GsH66 [R=301]'},
      {rewrite_rule => '^/help(/.*)?$ https://www.ocf.berkeley.edu/docs$1 [R]'},
      {rewrite_rule => '^/hiring$ https://docs.google.com/forms/d/e/1FAIpQLSeuJmYPV75oRWfVKEsIPYpPod2FqRwSqSj2i2-nRnY0NDCG8A/viewform [R]'},
      {rewrite_rule => '^/hiringinterest$ https://docs.google.com/forms/d/e/1FAIpQLSfuu2EN28bPksyA8h_BjRsHQvnzE8gk7gC5ySEAp50GExhUgg/viewform [R]'},
      {rewrite_rule => '^/hosting$ https://www.ocf.berkeley.edu/docs/services/web/ [R]'},
      {rewrite_rule => '^/hours$ https://ocf.io/lab#hours [R,NE]'},
      {rewrite_rule => '^/hpc$ https://www.ocf.berkeley.edu/docs/services/hpc/ [R]'},
      {rewrite_rule => '^/hpcstats$ https://grafana.ocf.berkeley.edu/d/N7Sb3nwik/hpc-slurm-dashboard?orgId=1&refresh=30s [R]'},
      {rewrite_rule => '^/https$ https://status.ocf.berkeley.edu/2014/10/moving-wwwocfberkeleyedu-to-https-only.html [R]'},
      {rewrite_rule => '^/infra$ https://docs.google.com/presentation/d/1RGyytdpdJycxhgCriwB575fCRVJLtErEdkrJrquRXD8/edit?usp=sharing [R]'},
      {rewrite_rule => '^/infosession$ https://docs.google.com/presentation/d/1nKb8HVykWUUei4UOSdzXCv1t351Poh7L5himavim3MI/edit?usp=sharing [R]'},
      {rewrite_rule => '^/internals?$ https://docs.google.com/presentation/d/1rfjCWpM0_IiHzKcxld5q4AYaoSQXeRVaj_R1YAOPl8A/edit [R]'},
      {rewrite_rule => '^/irc$ https://www.ocf.berkeley.edu/docs/contact/irc/ [R]'},
      {rewrite_rule => '^/job$ https://docs.google.com/document/d/1oS3ma415LbtuyeEuuoucWKYLcWOJaWmzhv2nIs5f718/edit [R]'},
      {rewrite_rule => '^/join$ https://www.ocf.berkeley.edu/account/register/ [R]'},
      {rewrite_rule => '^/joinstaff$ https://docs.google.com/presentation/d/1HNSWfHlPf_gwlOo7TJQcRwttGYUlo567h1u9qDxi48c/edit?usp=sharing [R]'},
      {rewrite_rule => '^/k$ https://kanboard.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/k/a$ https://kanboard.ocf.berkeley.edu/?controller=BoardViewController&action=show&project_id=2 [R]'},
      {rewrite_rule => '^/k/([0-9]+)$ https://kanboard.ocf.berkeley.edu/?controller=TaskViewController&action=show&task_id=$1 [R]'},
      {rewrite_rule => '^/register$ https://www.ocf.berkeley.edu/account/register/ [R]'},
      {rewrite_rule => '^/reserve$ https://www.ocf.berkeley.edu/docs/services/lab/lab-reservation-policy/ [R]'},
      {rewrite_rule => '^/lab$ https://www.ocf.berkeley.edu/docs/services/lab/ [R]'},
      {rewrite_rule => '^/labmap(/.*)?$ https://labmap.ocf.berkeley.edu$1 [R]'},
      {rewrite_rule => '^/mail$ https://www.ocf.berkeley.edu/docs/services/vhost/mail/ [R]'},
      {rewrite_rule => '^/mailrequest$ https://www.ocf.berkeley.edu/account/vhost/mail/ [R]'},
      {rewrite_rule => '^/mastodon$ https://mastodon.ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/matrix$ https://chat.ocf.berkeley.edu [R]'},
      {rewrite_rule => '^/meet$ https://meet.google.com/cqz-kjwj-hbx [R]'},
      {rewrite_rule => '^/membership$ https://www.ocf.berkeley.edu/docs/membership/ [R]'},
      {rewrite_rule => '^/minutes(/.*)?$ https://www.ocf.berkeley.edu/~staff/bod$1 [R]'},
      {rewrite_rule => '^/mirrorstats$ https://grafana.ocf.berkeley.edu/d/Jo_bRsyiz/mirrors?orgId=1 [R]'},
      {rewrite_rule => '^/mlk$ https://www.ocf.berkeley.edu/mlk [R]'},
      {rewrite_rule => '^/mysql$ https://www.ocf.berkeley.edu/docs/services/mysql/ [R]'},
      {rewrite_rule => '^/newstaff$ https://forms.gle/guESY2ykNkshNxsf8 [R]'},
      {rewrite_rule => '^/notes$ https://notes.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/now$ https://www.ocf.berkeley.edu/tv$1 [R]'},
      {rewrite_rule => '^/officers$ https://www.ocf.berkeley.edu/docs/about/officers/ [R]'},
      {rewrite_rule => '^/onboarding$ https://forms.gle/KKgp6fLhGkrfTKea8 [R]'},
      {rewrite_rule => '^/opstaff-schedule$ https://docs.google.com/spreadsheets/d/18EBPiC0HtW_ij_3MH5y3FyFVaG4ElnYHxJduQQ3IZM8/edit?usp=sharing [R]'},
      {rewrite_rule => '^/os$ https://docs.google.com/spreadsheets/d/1V4qYWOjQiafE_Xr-4X4nCUI1Sux5yJQNqHgzLV8j76I/edit [R]'},
      {rewrite_rule => '^/password$ https://www.ocf.berkeley.edu/account/password [R]'},
      {rewrite_rule => '^/printerlog$ https://docs.google.com/spreadsheets/d/1f4rLSmVt11oeFmO1yUUcXa-JcyFmDtloTWrYYPfYJoU/edit?usp=sharing [R]'},
      {rewrite_rule => '^/printers$ https://grafana.ocf.berkeley.edu/d/SKl6_71iz [R]'},
      {rewrite_rule => '^/printerstats$ https://grafana.ocf.berkeley.edu/d/SKl6_71iz [R]'},
      {rewrite_rule => '^/printing$ https://www.ocf.berkeley.edu/announcements/2016-02-09/printing [R]'},
      {rewrite_rule => '^/projects$ https://github.com/ocf/projects/issues [R]'},
      {rewrite_rule => '^/referendum-cost-breakdown$ https://docs.google.com/spreadsheets/d/1vIwrHlYtn1IcFH-1pTbUw2JvKNsR4rwlUzCJUbapID8/edit?usp=sharing [R]'},
      {rewrite_rule => '^/register2vote$ https://www.vote.org/register-to-vote/ [R]'},
      {rewrite_rule => '^/rt/?$ https://rt.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/rt/([0-9]+)$ https://rt.ocf.berkeley.edu/Ticket/Display.html?id=$1 [R]'},
      {rewrite_rule => '^/rt/([a-z]+)$ https://rt.ocf.berkeley.edu/Search/Results.html?Query=Queue\\ =\\ \'$1\'\\ AND\\ Status\\ =\\ \'__Active__\' [R]'},
      {rewrite_rule => '^/sdocs(/.*)?$ https://www.ocf.berkeley.edu/docs/staff$1 [R]'},
      {rewrite_rule => '^/senate-resolution$ https://docs.google.com/document/d/1UwjX4BJIzeQ6XjGBHu2rA51XUjywTBtPTzJN2CMGU4o/edit [R]'},
      {rewrite_rule => '^/senate-presentation$ https://docs.google.com/presentation/d/1LKUhzYaAydj-CgUEaHcBjrbMkYkmSnrZ9eouszodgqY/edit [R]'},
      {rewrite_rule => '^/servers$ https://www.ocf.berkeley.edu/docs/staff/backend/servers/ [R]'},
      {rewrite_rule => '^/serverstats$ https://grafana.ocf.berkeley.edu/d/7n0r8PUWz/servers?orgId=1&refresh=10s [R]'},
      {rewrite_rule => '^/signin$ https://goo.gl/forms/j2NU4u3T1pMKIPpu1 [R]'},
      {rewrite_rule => '^/short-?urls?$ https://www.ocf.berkeley.edu/docs/staff/tips/shorturl-tbl [R]'},
      {rewrite_rule => '^/short-?urls?pp$ https://github.com/ocf/puppet/blob/master/modules/ocf_www/manifests/site/shorturl.pp [R]'},
      {rewrite_rule => '^/sh$ https://ocf.io/staff-hours [R]'},
      {rewrite_rule => '^/shs$ https://github.com/ocf/etc/blob/master/configs/staff_hours.yaml [R]'},
      {rewrite_rule => '^/slack$ https://www.ocf.berkeley.edu/docs/contact/slack/ [R]'},
      {rewrite_rule => '^/social$ https://docs.google.com/forms/d/e/1FAIpQLSdLUhDYQug53NXdPEeJkLzB9JNUMUWJmXMoRSv18PkhEh4h4Q/viewform [R]'},
      {rewrite_rule => '^/social-?rules$ https://www.recurse.com/social-rules [R]'},
      {rewrite_rule => '^/socialbingo$ https://docs.google.com/forms/d/e/1FAIpQLSeU2iZf_SnephTu6KQ_VfeFBI-YMetTSioeibFKwgtoITlG-w/viewform [R]'},
      {rewrite_rule => '^/ssh$ https://www.ocf.berkeley.edu/docs/services/shell/ [R]'},
      {rewrite_rule => '^/staff$ https://www.ocf.berkeley.edu/about/staff [R]'},
      {rewrite_rule => '^/staffhours$ https://ocf.io/staff-hours [R]'},
      {rewrite_rule => '^/staff-hours$ https://www.ocf.berkeley.edu/staff-hours [R]'},
      {rewrite_rule => '^/staff-hours-signup$ https://github.com/ocf/etc/blob/master/configs/staff_hours.yaml [R]'},
      {rewrite_rule => '^/staff_hours_signup$ https://github.com/ocf/etc/blob/master/configs/staff_hours.yaml [R]'},
      {rewrite_rule => '^/staff-?training$ https://decal.ocf.io/resources/ [R]'},
      {rewrite_rule => '^/starter-?tasks$ https://www.ocf.berkeley.edu/docs/staff/startertasks/ [R]'},
      {rewrite_rule => '^/stats(/.*)?$ https://www.ocf.berkeley.edu/stats$1 [R]'},
      {rewrite_rule => '^/status$ https://status.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/subdomains$ https://www.ocf.berkeley.edu/announcements/2023-03-01/subdomains [R]'},
      {rewrite_rule => '^/swag$ https://ocf.io/s/swag [R]'},
      {rewrite_rule => '^/templates?$ https://templates.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/buster$ https://www.ocf.berkeley.edu/docs/staff/backend/buster/ [R]'},
      {rewrite_rule => '^/s/(.+)$ https://www.ocf.berkeley.edu/api/shorturl/$1 [R]'},
      {rewrite_rule => '^/stf-cost-breakdown$ https://docs.google.com/spreadsheets/d/1U3YfU5S1hyi4c9u1vME84lz5hQPz23LKWCaD8mq4JHI/edit [R]'},
      {rewrite_rule => '^/survey$ https://goo.gl/forms/sk1s0dnuxDY71vBR2 [R]'},
      {rewrite_rule => '^/today$ https://www.ocf.berkeley.edu/tv$1 [R]'},
      {rewrite_rule => '^/teamsus$ https://docs.google.com/spreadsheets/d/16KIXvgsBP5VLWmX6QXHxcn147ZYRWSchXL-f3iFYsHo/edit?usp=sharing [R]'},
      {rewrite_rule => '^/tw(/.*)?$ https://ocf.io/twitter$1 [R]'},
      {rewrite_rule => '^/twitter(/.*)?$ https://twitter.com/ucbocf$1 [R]'},
      {rewrite_rule => '^/tv(/.*)?$ https://www.ocf.berkeley.edu/tv$1 [R]'},
      {rewrite_rule => '^/tv/map(/.*)?$ https://labmap.ocf.berkeley.edu$1 [R]'},
      {rewrite_rule => '^/vhost$ https://www.ocf.berkeley.edu/docs/services/vhost/ [R]'},
      {rewrite_rule => '^/vhost-mail$ https://www.ocf.berkeley.edu/docs/services/vhost/mail/ [R]'},
      {rewrite_rule => '^/wiki$ https://www.ocf.berkeley.edu/docs/ [R]'},
      {rewrite_rule => '^/wordpress$ https://www.ocf.berkeley.edu/docs/services/web/wordpress/ [R]'},
      {rewrite_rule => '^/web$ https://www.ocf.berkeley.edu/docs/services/web/ [R]'},
      {rewrite_rule => '^/xkcd$ https://xkcd.ocf.berkeley.edu/ [R]'},
      {rewrite_rule => '^/youtube$ https://www.youtube.com/channel/UCx6SI8vROy9UGje0IiLkk8w [R]'},
      {rewrite_rule => '^/zoom$ https://berkeley.zoom.us/j/92953066816 [R]'},

      # Otherwise, send a temporary redirect to the appropriate userdir
      {rewrite_rule => '^/~?([a-z0-9]{3,16}(?:/.*)?)$ https://www.ocf.berkeley.edu/~$1 [R]'},
    ],

    headers       => ['always set Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"'],
  }

  # canonical redirects
  apache::vhost { 'shorturl-http-redirect':
    servername      => 'ocf.io',
    serveraliases   => ['dev-ocf-io.ocf.berkeley.edu', 'www.ocf.io'],
    port            => 80,
    docroot         => '/var/www/html',

    redirect_status => 301,
    redirect_dest   => $canonical_url;
  }
}
