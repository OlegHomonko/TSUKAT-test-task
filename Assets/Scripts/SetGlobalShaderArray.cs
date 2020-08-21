using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetGlobalShaderArray : MonoBehaviour
{
    public const int ArrayLen = 16;
    private static readonly int CollidedObjects = Shader.PropertyToID("_collidedObjects");
    public static SetGlobalShaderArray Instance { get; private set; }

    private Vector4[] _globalArray = new Vector4[ArrayLen];

    private Material _material;
    

    private void Awake()
    {
        if (Instance != null)
        {
            Destroy(this);
            return;
        }

        Instance = this;

        var rend = GetComponent<MeshRenderer>();
        if (rend == null)
        {
            return;
        }

        _material = rend.material;
    }

    public void SetArrayVector(Vector4 v4, int arrayID)
    {
        if (arrayID < 0 || arrayID >= ArrayLen)
        {
            return;
        }

        _globalArray[arrayID] = v4;
    }

    private void Update()
    {
        _material.SetVectorArray(CollidedObjects, _globalArray);
    }
}
