#!/bin/sh

#  list_xcode_provisioning_profiles.sh
#  ZMPackager
#
#  Created by Yuri Boyka on 2019/1/7.
#  Copyright © 2019 Yuri Boyka. All rights reserved.

list_xcode_provisioning_profiles() {
while IFS= read -rd '' f; do
/usr/libexec/PlistBuddy 2>/dev/null -c 'Print :Entitlements:application-identifier' /dev/stdin \
<<<$(security cms -D -i "$f")

done < <(find "$HOME/Library/MobileDevice/Provisioning Profiles" -name '*.mobileprovision' -print0)
}
