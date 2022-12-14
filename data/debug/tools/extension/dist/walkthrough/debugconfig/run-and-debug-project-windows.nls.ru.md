<h1 data-loc-id="walkthrough.windows.title.run.and.debug.your.file">Run and debug your C++ file on Windows</h1>
<p data-loc-id="walkthrough.windows.run.and.debug.your.file">To run and debug your C++ file in VS Code:</p>
<ol>
<li><p data-loc-id="walkthrough.windows.instructions1">Open the C++ source file that you want to run and debug. Make sure this file is active (currently displayed and selected) in the editor.</p>
</li>
<li><p data-loc-id="walkthrough.windows.press.f5">Press <code>F5</code>. Or, from the main menu, choose <strong><span data-loc-id="walkthrough.windows.run" data-loc-hint="Refers to Run command on main menu">Run</span> &gt; <span data-loc-id="walkthrough.windows.start.debugging" data-loc-hint="Refers to Start Debugging command under Run menu on main menu">Start Debugging</span></strong>.</p>
</li>
<li><p data-loc-id="walkthrough.windows.select.compiler">Select <strong>C++ (Windows)</strong>.</p>
</li>
<li><p data-loc-id="walkthrough.windows.choose.build.active.file">Choose <strong>cl.exe - <span data-loc-id="walkthrough.windows.build.and.debug.active.file" data-loc-hint="Should be the same as translation for build.and.debug.active.file in extension.ts">Сборка и отладка активного файла</span></strong>.</p>
</li>
</ol>
<p data-loc-id="walkthrough.windows.after.running">After running and debugging your C++ file for the first time, you'll notice two new files inside your project's <strong>.vscode</strong> folder: <strong>tasks.json</strong> and <strong>launch.json</strong>.</p>

<p data-loc-id="walkthrough.windows.for.more.complex">For more complex build and debug scenarios, you can customize your build tasks and debug configurations in <span>tasks.json</span> and <span>launch.json</span>. For example, if you normally pass arguments to your compiler when building from the command line, you can specify those arguments in <span>tasks.json</span> using the <strong>compilerArgs</strong> property. Similarly, you can define arguments to pass to your program for debugging in <span>launch.json</span>.</p>
