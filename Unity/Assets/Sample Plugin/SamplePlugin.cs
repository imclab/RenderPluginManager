using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;

public class SamplePlugin : MonoBehaviour {


	[DllImport("__Internal")]
	private extern static void _registerPlugin();
	
	public static void RegisterPlugin() {
		if (Application.platform == RuntimePlatform.IPhonePlayer) {
			_registerPlugin();
		}
	}


	[DllImport("__Internal")]
	private extern static void _unregisterPlugin();

	public static void UnregisterPlugin() {
		if (Application.platform == RuntimePlatform.IPhonePlayer) {
			_unregisterPlugin();
		}
	}


}
