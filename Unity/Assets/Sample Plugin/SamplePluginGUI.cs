using UnityEngine;
using System.Collections;

public class SamplePluginGUI : MonoBehaviour {
	
	private bool _registered = false;
	private string label = "";

	void OnGUI() {
		if (_registered) {
			GUI.color = Color.red;
			label = "Unregister";
		} else {
			GUI.color = Color.white;
			label = "Register";
		}


		if (GUI.Button(new Rect(10, 10, 100, 50), label)) {

			if (_registered) {
				SamplePlugin.UnregisterPlugin();
				_registered = false;
			} else {
				SamplePlugin.RegisterPlugin();
				_registered = true;
			}

		}

	}



}
