﻿/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is [Open Source Virtual Machine.].
 *
 * The Initial Developer of the Original Code is
 * Adobe System Incorporated.
 * Portions created by the Initial Developer are Copyright (C) 2012
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Adobe AS3 Team
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */
 
package {

    import flash.system.Worker;
    import flash.system.WorkerDomain;
    import avmplus.System;

    if (Worker.current.isPrimordial) {
        var SECTION = "Workers";
        var VERSION = "as3";
        var TITLE   = "test Worker api";
        startTest();
        writeHeaderToLog(SECTION+" "+TITLE);

        AddTestCase("test main worker is primordial",true,Worker.current.isPrimordial);

    // test Worker constructor throws exception and does not create a worker
        var constr_worker:Worker=null;
        var constr_worker_exc:String="";
        try {
            constr_worker=new Worker();
        } catch (e) {
            constr_worker_exc=e.toString();
        }
        AddTestCase("test cannot use Worker Constructor, does not create worker",null,constr_worker);
        AddTestCase("test cannot use Worker Constructor, throws exception","ArgumentError: Error #2012",constr_worker_exc.substring(0,"ArgumentError: Error #2012".length));

    // test background worker is not primordial
        var bck_worker:Worker=WorkerDomain.current.createWorkerFromPrimordial();
        AddTestCase("test background worker is NOT primordial",false,bck_worker.isPrimordial);

    // test worker state
        AddTestCase("test main worker state is running","running",Worker.current.state);
        AddTestCase("test background worker state is new","new",bck_worker.state);
        bck_worker.start();
	    AddTestCase("test after start on background worker state is running","new",bck_worker.state);
        bck_worker.terminate();
        var start:uint=getTimer();
        while (bck_worker.state!="terminated") {
            System.sleep(10);
            if (getTimer()-start>2000) break;
        }
        print("done after "+(getTimer()-start));
	    AddTestCase("test after stop on background worker state is terminated","terminated",bck_worker.state);
        test();
    } else {
        trace("in background worker");
    }
}