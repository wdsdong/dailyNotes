##Unix，Windows，Mac OS，Linux

This is going to be a long story, but you asked for details, right?

Let's take it from the top, shall we? This is going to be fun, I promise!

In the beginning, there was something called the PC (Personal Computer). This was the first computer that a user can buy for their personal use at home. This was created by a huge company called IBM.

IBM was in the computer business for a very long time, but the PC was a new idea they invented in the early 80s. They needed an Operating System to run it, so (after a long story), they called Microsoft and made an agreement to use MS DOS as the OS for their PC.

Meanwhile, in a small garage somewhere else, two teenagers, both named Steve, were playing around, trying to invent their own computer. One of them was a genius (not the one you see in the media), so he designed and built the whole system, then wrote all the software for it (told ya: genius). They called this system the Macintosh and started a company called Apple to sell it.

Let’s forget all the above, and go to a big telecommunications company at the time called Bell labs (later known as AT&T), in 1969. Two guys named Ken Thompson and Dennis Ritchie decided to make an operating system of their own, based on a failed OS project named MULTICS (Multiplexed Information and Computing Service), it failed in the essence that it never became a mainstream OS, but the ideas invented in MULTICS are largely used today by many OSes. Any how, K&D made their OS, called it UNICS, playing on the “Multiplexed” part of the name. They later changed it to become UNIX, a much cooler way to write the name.

UNIX ran on a raggedly old computer K&D found laying around Bell labs, called PDP-11 (Edit: Actually it was PDP-7 as Jesse Pollard pointed in a comment). They wanted to port this OS to other platforms, so in the early 70’s, Brian Kernighan and Dennis Ritchie invented the C programming language (known as K&R C).

Bell labs couldn’t take part in software development at that time due to federal restrictions, so they licensed their UNIX product for educational use in the university world. The University of California at Berkeley (UCB) took the UNIX OS, did a lot of research and improvements on it, and eventually created their own version of the system, later to be known as BSD UNIX (Berkeley Standard Distribution). The original UNIX continued to become the infamous System V UNIX (SysV, read sys-5).

So for now, we have three different worlds: (1) the PC world with Microsoft DOS on top of it, (2) the Apple world with Macintosh the sole player in it, (3) the university world with UNIX.

Now let’s go back to the PC world in the mid-late 80s and see what’s happening.

Now Apple is trying to push their frontier and make a bigger contribution to the market. All the systems up to that point ran on a TUI (text user interface, yes - that ugly black screen). Xerox (yes - the photocopying-machine-thingy) developed a GUI (Graphical User Interface), so Apple borrowed that. Microsoft later was envious of it and decided to borrow it also. They started the “Windows” project by releasing Windows 1.0, which was only a fancy file manager on top of MS DOS. It was not until Windows 3.0 that Windows was promising to become an important part of their world. Windows continued to be a “secondary” layer on top of MS DOS (i.e. the real OS was DOS, not Windows) until Windows 2000, which was the merger between the “normal” Windows version that we used at our homes, and the “professional” Windows version that was called Win NT (New Technology), yeah - corporate gets the good stuff. Anyhow, after Win 2k, Windows became a standalone Operating System, independent of MS DOS.

Now let’s go back to UNIX.

Due to different problems with licensing and copying and whatnot, a college professor named Andrew Tanenbaum, who was teaching Operating Systems, decided to make a clone of UNIX, without using UNIX code, to avoid legal trouble. He made a system (with the aid of some TAs and other interested programmers) and named it MINIX (Mini-UNIX). For a long time (till today) the system has been used for teaching in many institutions.

MINIX was great, but it had two problems: (1) the code itself was given to you after you buy the accompanying book (I don’t remember if there was a separate fee for the code), and (2) the kernel was a micro-kernel (let’s skip the jargon, shall we?).

Now fast forward to 1991, in the University of Helsinki, Finland. A graduate student, named Linus Torvalds, started a hobby project to make a UNIX-like kernel. He was inspired by MINIX, but he didn’t like some of the design decisions (like being a micro-kernel), so he made his own.

Linux (the kernel) has since been combined with an Operating System called GNU (stands for “GNU’S NOT UNIX”) to make the fully operational GNU/Linux (what you call, erroneously, Linux). Many different vendors and communities started packaging GNU/Linux with some other software to produce different OS distributions, called “distros” for short. Ubuntu is only one of them distros.

UNIX nowadays has transformed from an OS to a standard that defines how OSes should work in order for software to be portable. UNIX is now a trademark of The Open Group. The standard is known as the Single Unix Specification (SUS) or the POSIX (Portable Operating Systems Interface).

MacOS is the result of merging the iOS kernel with a variant of BSD UNIX known as FreeBSD.

Windows is, well, Windows.




