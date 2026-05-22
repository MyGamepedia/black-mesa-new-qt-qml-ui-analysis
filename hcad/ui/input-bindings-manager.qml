pragma Singleton

import QtQuick 2.9
import CrowbarCollective 1.0

QtObject {
    readonly property variant commandMap:
        (function () {
            var map = {},
                labels = L10n.strings.options.bindings;

            map['+forward'] = labels.move_forward;
            map['+back'] = labels.move_backward;
            map['+moveleft'] = labels.strafe_left;
            map['+moveright'] = labels.strafe_right;
            map['+jump'] = labels.jump;
            map['+duck'] = labels.duck;
            map['+speed'] = labels.sprint;

            map['+use'] = labels.use;
            map['+attack'] = labels.primary;
            map['+attack2'] = labels.secondary;
            map['+reload'] = labels.reload;
            map['impulse 100'] = labels.flashlight;
            map['+zoom'] = labels.zoom;
            map['invnext'] = labels.nextWeapon;
            map['invprev'] = labels.previousWeapon;
            map['lastinv'] = labels.lastWeapon;
            map['slot1'] = labels.weaponCategory1;
            map['slot2'] = labels.weaponCategory2;
            map['slot3'] = labels.weaponCategory3;
            map['slot4'] = labels.weaponCategory4;
            map['slot5'] = labels.weaponCategory5;
            map['slot6'] = labels.weaponCategory6;

            map['save quick'] = labels.quickSave;
            map['load quick'] = labels.quickLoad;
            map['toggleconsole'] = labels.devConsole;
            map['incrementvar closecaption 0 1 1'] = labels.ccSoundEffects;
            map['+moveup'] = labels.swimUp;
            map['+movedown'] = labels.swimDown;
            map['+lookup'] = labels.lookUp;
            map['+lookdown'] = labels.lookDown;
            map['+left'] = labels.turnLeft;
            map['+right'] = labels.turnRight;

            //map['chooseteam'] = labels.chooseTeam;
            //map['+voicerecord'] = labels.voiceChat;

            map['use weapon_crowbar'] = labels.weaponCrowbar;
            map['use weapon_glock'] = labels.weaponPistol;
            map['use weapon_357'] = labels.weapon357;
            map['use weapon_mp5'] = labels.weaponMP5;
            map['use weapon_shotgun'] = labels.weaponShotgun;
            map['use weapon_crossbow'] = labels.weaponCrossbow;
            map['use weapon_rpg'] = labels.weaponRPG;
            //map['use weapon_tau'] = labels.weaponTau;
            map['use weapon_gluon'] = labels.weaponGluon;
            //map['use weapon_hivehand'] = labels.weaponHiveHand;
            map['use weapon_frag'] = labels.weaponFrag;
            map['use weapon_tripmine'] = labels.weaponTripmine;
            map['use weapon_satchel'] = labels.weaponSatchel;
            map['use weapon_snark'] = labels.weaponSnarks;

            return Object.freeze(map);
        }())

    readonly property variant mouseMap:
        (function () {
            var map = {};

            // https://doc.qt.io/qt-5/qt.html#MouseButton-enum
            // src/inputsystem/key_translation.cpp
            map[Qt.LeftButton]          = 'MOUSE1';
            map[Qt.RightButton]         = 'MOUSE2';
            map[Qt.MidButton]           = 'MOUSE3';
            map[Qt.BackButton]          = 'MOUSE4';
            map[Qt.ForwardButton]       = 'MOUSE5';

            map.wheelUp                 = 'MWHEELUP';
            map.wheelDown               = 'MWHEELDOWN';

            return Object.freeze(map);
        }())

    readonly property variant keyMap:
        (function () {
            var map = {};

            // https://doc.qt.io/qt-5/qt.html#Key-enum
            // src/inputsystem/key_translation.cpp
            map[Qt.Key_Escape]          = 'ESCAPE';
            map[Qt.Key_Tab]             = 'TAB';
            map[Qt.Return]              = 'ENTER';
            map[Qt.Key_A]               = 'a';
            map[Qt.Key_B]               = 'b';
            map[Qt.Key_C]               = 'c';
            map[Qt.Key_D]               = 'd';
            map[Qt.Key_E]               = 'e';
            map[Qt.Key_F]               = 'f';
            map[Qt.Key_G]               = 'g';
            map[Qt.Key_H]               = 'h';
            map[Qt.Key_I]               = 'i';
            map[Qt.Key_J]               = 'j';
            map[Qt.Key_K]               = 'k';
            map[Qt.Key_L]               = 'l';
            map[Qt.Key_M]               = 'm';
            map[Qt.Key_N]               = 'n';
            map[Qt.Key_O]               = 'o';
            map[Qt.Key_P]               = 'p';
            map[Qt.Key_Q]               = 'q';
            map[Qt.Key_R]               = 'r';
            map[Qt.Key_S]               = 's';
            map[Qt.Key_T]               = 't';
            map[Qt.Key_U]               = 'u';
            map[Qt.Key_V]               = 'v';
            map[Qt.Key_W]               = 'w';
            map[Qt.Key_X]               = 'x';
            map[Qt.Key_Y]               = 'y';
            map[Qt.Key_Z]               = 'z';
            map[Qt.Key_0]               = '0';
            map[Qt.Key_1]               = '1';
            map[Qt.Key_2]               = '2';
            map[Qt.Key_3]               = '3';
            map[Qt.Key_4]               = '4';
            map[Qt.Key_5]               = '5';
            map[Qt.Key_6]               = '6';
            map[Qt.Key_7]               = '7';
            map[Qt.Key_8]               = '8';
            map[Qt.Key_9]               = '9';
            map[Qt.Key_F1]              = 'F1';
            map[Qt.Key_F2]              = 'F2';
            map[Qt.Key_F3]              = 'F3';
            map[Qt.Key_F4]              = 'F4';
            map[Qt.Key_F5]              = 'F5';
            map[Qt.Key_F6]              = 'F6';
            map[Qt.Key_F7]              = 'F7';
            map[Qt.Key_F8]              = 'F8';
            map[Qt.Key_F9]              = 'F9';
            map[Qt.Key_F10]             = 'F10';
            map[Qt.Key_F11]             = 'F11';
            map[Qt.Key_F12]             = 'F12';
            map[Qt.Key_Shift]           = 'SHIFT';
            map[Qt.Key_Alt]             = 'ALT';
            map[Qt.Key_Control]         = 'CTRL';
            map[Qt.Key_Space]           = 'SPACE';
            map[Qt.Key_Backspace]       = 'BACKSPACE';
            map[Qt.Key_CapsLock]        = 'CAPSLOCK';
            map[Qt.Key_ScrollLock]      = 'SCROLLLOCK';
            map[Qt.Key_NumLock]         = 'NUMLOCK';
            map[Qt.Key_Insert]          = 'INS';
            map[Qt.Key_Delete]          = 'DEL';
            map[Qt.Key_End]             = 'END';
            map[Qt.Key_Home]            = 'HOME';
            map[Qt.Key_PageUp]          = 'PGUP';
            map[Qt.Key_PageDown]        = 'PGDN';
            map[Qt.Key_Apostrophe]      = "'";
            map[Qt.Key_Semicolon]       = ';';
            map[Qt.Key_Left]            = 'LEFTARROW';
            map[Qt.Key_Right]           = 'RIGHTARROW';
            map[Qt.Key_Down]            = 'DOWNARROW';
            map[Qt.Key_Up]              = 'UPARROW';
            map[Qt.Key_Equal]           = '=';
            map[Qt.Key_Backslash]       = '\\';
            map[Qt.Key_AsciiTilde]      = '`';
            map[Qt.Key_Slash]           = '/';
            map[Qt.Key_Period]          = '.';
            map[Qt.Key_Comma]           = ',';
            map[Qt.Key_BracketLeft]     = '[';
            map[Qt.Key_BracketRight]    = ']';
            map[Qt.Key_Minus]           = '-';

            return Object.freeze(map);
        }())

    property variant bindings
    property variant bindingsKeyMap

    property var inputBindingCallback: null
    property bool isBinding: !!inputBindingCallback

    property bool isSelected: !!selectedCfg
    property variant selectedCfg

    property variant conflicts
    property variant conflictCfg

    signal bindingSet()
    signal bindingClear()
    signal defaultsRestored()

    function _readConfigFile(url, callback) {
        var xhr = new XMLHttpRequest;

        function parseConfig(response) {
            var map = {},
                lineParser = /bind\s+\"(.*)\"\s+\"(.*)\"/;

            response.split('\n').forEach(function (line) {
                var parsed = line.match(lineParser);

                if (parsed) {
                    var command = parsed[2];

                    if (!map[command]) {
                        map[command] = [parsed[1]];
                    } else {
                        map[command].push(parsed[1]);
                    }
                }
            });

            if (callback) {
                callback(map);
            }
        }

        xhr.open("GET", url);
        xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                parseConfig(xhr.response);
            }
        }

        xhr.send();
    }

    function _saveBindingModifications() {
        BlackMesaEngine.executeClientCommandUnrestricted('exec userconfig.cfg; host_writeconfig');
    }

    function _resetConflicts() {
        conflicts = null;
        conflictCfg = null;
    }

    function getBindingComponentConfig(command) {
        return {
            label: commandMap[command],
            type: 'binding',
            command: command,
            key1: '',
            key2: ''
        }
    }

    function getBindings(commands, callback) {
        _readConfigFile("vfs:///cfg/config.cfg", function (response) {
            bindings = response;
            bindingsKeyMap = {};

            var map = {};

            Object.keys(bindings).forEach(function (command) {
                var keys = response[command];

                keys.forEach(function (key) {
                    if (bindingsKeyMap[key]) {
                        bindingsKeyMap.push(command);
                    } else {
                        bindingsKeyMap[key] = [command];
                    }
                });

                if (commands.indexOf(command) !== -1) {
                    map[command] = keys;
                }
            });

            callback(map);
        });
    }

    function selectBinding(cfg) {
        selectedCfg = cfg;
    }

    function clearSelection() {
        selectedCfg = null;
    }

    function handleBindingResponse(event) {
        inputBindingCallback(event);
        inputBindingCallback = null;
    }

    function startBindingRequest() {
        var cfg = selectedCfg;

        function setBinding(command, current, key) {
            var unbindCurrent = 'unbind ' + current,
                unbindKey = 'unbind ' + key,
                bind = 'bind ' + key + ' "' + command + '"';

            if (current) { BlackMesaEngine.executeClientCommandUnrestricted(unbindCurrent); }

            BlackMesaEngine.executeClientCommandUnrestricted(unbindKey);
            BlackMesaEngine.executeClientCommandUnrestricted(bind);
        }

        clearSelection();
        cfg.begin();
        BlackMesaEngine.requestKeyCapture();

        inputBindingCallback = function (event) {
            function cancel() {
                _resetConflicts();
                cfg.end({ key: cfg[cfg.ordinal], code: event.code });
            }

            if (event.key === 'ESCAPE') {
                cancel();
            } else {
                var commands = bindingsKeyMap[event.key],
                    execBindings = function () {
                        var key1 = cfg.ordinal === 'key1' ? event.key : cfg.key1,
                            key2 = cfg.ordinal === 'key2' ? event.key : cfg.key2;

                        if (key1) { setBinding(cfg.command, cfg.current, key1); }
                        if (key2) { setBinding(cfg.command, cfg.current, key2); }

                        _saveBindingModifications();
                        _resetConflicts();

                        cfg.end(event);
                        bindingSet();
                    };

                if (commands && commands.indexOf(cfg.command) === -1) {
                    conflictCfg = {
                        bindingCfg: cfg,
                        key: event.key,
                        confirm: execBindings,
                        cancel: cancel
                    };

                    // make the conflict the human readable string ("Move Forward" instead of "+forward")
                    conflicts = commands.map(function (command) { return commandMap[command]; });
                } else {
                    execBindings();
                }
            }
        }
    }

    function clearSelectedBinding() {
        var cfg = selectedCfg;

        clearSelection();
        BlackMesaEngine.executeClientCommandUnrestricted('unbind ' + cfg[cfg.ordinal]);
        _saveBindingModifications();
        bindingClear();
    }

    function restoreDefaultBindings() {
        _readConfigFile("vfs:///cfg/config_default.cfg", function (response) {
            BlackMesaEngine.executeClientCommandUnrestricted('unbindall');
            BlackMesaEngine.executeClientCommandUnrestricted('exec config_default.cfg');

            // Object.keys(response).forEach(function (command) {
                // var keys = response[command];
                // BlackMesaEngine.executeClientCommandUnrestricted('unbind ' + keys[0] );
                // BlackMesaEngine.executeClientCommandUnrestricted('bind ' + keys[0] + ' "' + command + '"');

                // if (keys[1]) {
                    // BlackMesaEngine.executeClientCommandUnrestricted('bind ' + keys[1] + ' "' + command + '"');
                // }
            // });

            _saveBindingModifications();
            defaultsRestored();
        });
    }
}
