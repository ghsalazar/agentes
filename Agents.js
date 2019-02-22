function Agent(x=0, y=0){
   THREE.Object3D.call(this);
   this.position.x = x;
   this.position.y = y;
}

Agent.prototype = new THREE.Object3D();
Agent.prototype.sense =
   function(environment) {};
Agent.prototype.plan =
   function(environment) {};
Agent.prototype.act =
   function(environment) {};
function Environment() {
   THREE.Scene.call(this);
}

Environment.prototype = new THREE.Scene();
Environment.prototype.sense = function() {
   var c = this.children;
   for ( var i = 0; i < c.length; i++ )
          if (c[i].sense !== undefined)
         c[i].sense(this);
}

Environment.prototype.plan = function() {
   var c = this.children;
   for ( var i = 0; i < c.length; i++ )
      if (c[i].plan !== undefined)
         c[i].plan(this);
}

Environment.prototype.act = function() {
   var c = this.children;
   for ( var i = 0; i < c.length; i++ )
      if (c[i].act !== undefined)
         c[i].act(this);
}
