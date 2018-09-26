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

DecideFireJS.prototype.logout = function() {
    firebase.auth().signOut();
};

DecideFireJS.prototype.currentUser = function(callback) {
    let user = firebase.auth().currentUser;
    if(user != null) {
        getUser(user.uid, callback);
    } else {
        callback(null);
    }
};

DecideFireJS.prototype.checkEmail = function(email, callback) {
    console.log("checking " + email);
    firebase.auth().fetchSignInMethodsForEmail(email).then((methods) => callback(methods, "")).catch((error) => callback([], error));
};

DecideFireJS.prototype.signup = function(email, password, displayName, callback) {
    firebase.auth().createUserWithEmailAndPassword(email, password).then((cred) => {
        callback(new DecideFireLoginResultJS(new DecideFireUserJS(cred.user.uid, displayName)));
        let uid = cred.user.uid;
        firebase.database().ref("users").child(uid).set({
            name: displayName
        });
    }).catch((error) => {
        callback(new DecideFireLoginResultJS(null, new DecideFireErrorJS(error)));
    });
};

DecideFireJS.prototype.login = function(email, password, callback) {
    firebase.auth().signInAndRetrieveDataWithEmailAndPassword(email, password).then((cred) => {
        let uid = cred.user.uid;
        getUser(uid, (user) => {
            callback(new DecideFireLoginResultJS(user));
        });
    }).catch((error) => {
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
