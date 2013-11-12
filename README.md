update-subtrees
================

A simple ruby script to manage subtrees.

Storytime!
----------

Let's suppose you're writing multiple applications, which may share some 
functionality. To keep things DRY, the code is modular, with the common code 
in its own repositories, and the application extending that where it does not 
make sense to share.

Shall we be creative, and call the modules foo and bar?

Your application might look something like this...

	app-a/
	  application.source
	  modules.conf
	  extra.source
	  modules/
	    foo/
	      foo.source
	    bar/
	      bar.source
	      bar-extensions.source
	
	app-b/
	  application.source
	  modules.conf
	  modules/
	    foo/
	      foo.source
	      foo-extensions.source
	    bar/
	      bar.source

In *app-a*, you have extended *bar* with some extra functionality that doesn't 
make sense to push upstream to the *bar* module, and you have done that same 
with *foo* in *app-b*.

Let's say you're using bar v1.6.0 in both projects, and foo v1.2.0. Your 
*modules.conf* looks something like this:

	foo:
	  remote: /path/to/foo/repo
	  version: 1.2.0
	bar:
	  remote: /path/to/bar/repo
	  version: 1.6.0

Suddenly, business requirements change, and an incompatible change is made to 
the *bar* API. Gasp! Since this change may break downstream applications 
depending on *bar*, the version number is bumped to v2.0.0, because we use 
[Semantic Versioning](http://semver.org).

Since *app-b* is using vanilla *bar*, the update is trivial. modules.conf is 
edited, the version number bumped to 2.0.0, and *update-subtrees.rb* is run.

*app-a* has extended *bar*, so integrating the new version will probably take 
more work. When that has been done, updating to 2.0.0 is the same, but it can 
be integrated when time permits.

git-subtrees make this sort of architecture easy to achieve, but the syntax is 
a bit gritty. update-subtrees.rb doesn't do any great magic, it just makes it 
easier to work with for developers who find the following command daunting:

	git subtree --prefix modules/foo https://github.com/author/repo master --squash

And for projects where there are a great many modules of this sort.

Why not git submodules?
-----------------------
Because submodules don't play nice with overlapping directory structures.

Dependencies
------------
git
git-subtree from [git/contrib](https://github.com/git/git/tree/master/contrib/subtree)
ruby
ruby-yaml

Usage
-----

Edit modules.conf, structure is YAML.

On the first run...
	update-subtrees.rb init

To update to the versions specified in modules.conf...
	update-subtrees.rb
