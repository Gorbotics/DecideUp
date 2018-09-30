let getUser = function(uid, callback) {
    firebase.database().ref("users").child(uid).once("value", (snap) => {
        if(snap.val() != null) {
            callback(new DecideFireUserJS(uid, snap.val().name));
        } else {
            callback(new DecideFireUserJS(uid, "Unknown Name"));
        }
    });
};


function DecideFireJS() {

}

DecideFireJS.prototype.getKeysForObject = function(obj) {
    return Object.keys(obj);
};

DecideFireJS.prototype.push = function(path, obj, callback) {
    let ref = firebase.database().ref(path).push();
    ref.set(obj).then(() => {
        callback(ref.key);
    });
};

DecideFireJS.prototype.save = function(path, obj, callback) {
    firebase.database().ref(path).set(obj).then(() => {
        callback();
    });
};

DecideFireJS.prototype.get = function(path, callback) {
    console.log("getting at path " + path);
    firebase.database().ref(path).once("value", (snap) => {
        callback(snap.val());
    });
};

DecideFireJS.prototype.logout = function() {
    firebase.auth().signOut();
};

DecideFireJS.prototype.currentUser = function(callback) {
    firebase.auth().onAuthStateChanged(function(user) {
        if (user != null) {
            getUser(user.uid, callback);
        } else {
            callback(null);
        }
    });
};

DecideFireJS.prototype.checkEmail = function(email, callback) {
    console.log("checking " + email);
    firebase.auth().fetchSignInMethodsForEmail(email).then((methods) => callback(methods, "")).catch((error) => callback([], error));
};

DecideFireJS.prototype.signup = function(email, password, displayName, callback) {
    firebase.auth().setPersistence(firebase.auth.Auth.Persistence.LOCAL)
        .then(function() {
             return firebase.auth().createUserWithEmailAndPassword(email, password).then((cred) => {
                let uid = cred.user.uid;
                 firebase.auth().signInAndRetrieveDataWithEmailAndPassword(email, password).then((cred) => {
                     let user = new DecideFireUserJS(uid, displayName);
                     callback(new DecideFireLoginResultJS(user));
                     firebase.database().ref("users").child(uid).set({
                         name: displayName
                     });
                 });
            });
        })
        .catch(function(error) {
            callback(new DecideFireLoginResultJS(null, new DecideFireErrorJS(error)));
        });

};

DecideFireJS.prototype.login = function(email, password, callback) {
    firebase.auth().setPersistence(firebase.auth.Auth.Persistence.SESSION)
        .then(function() {
            return firebase.auth().signInAndRetrieveDataWithEmailAndPassword(email, password).then((cred) => {
                let uid = cred.user.uid;
                getUser(uid, (user) => {
                    callback(new DecideFireLoginResultJS(user));
                });
            });
        })
        .catch(function(error) {
            callback(new DecideFireLoginResultJS(null, new DecideFireErrorJS(error)));
        });
};

function DecideFireUserJS(uid, name) {
    this._uid = uid;
    this._name = name;
}

DecideFireUserJS.prototype.uid = function() {
    return this._uid;
};

DecideFireUserJS.prototype.name = function() {
    return this._name;
};

function DecideFireErrorJS(error) {
    this.error = error;
}

DecideFireErrorJS.prototype.code = function() {
    return this.error.code;
};

DecideFireErrorJS.prototype.message = function() {
    return this.error.message;
};

function DecideFireLoginResultJS(user, error) {
    this._user = user;
    this._error = error;
}

DecideFireLoginResultJS.prototype.user = function() {
    return this._user;
};

DecideFireLoginResultJS.prototype.error = function() {
    return this._error;
};
