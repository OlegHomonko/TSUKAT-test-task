using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetGlobalShaderArray : MonoBehaviour
{
    private const int ArrayLen = 16;
    private static readonly int CollidedObjects = Shader.PropertyToID("_collidedObjects");
    
    public Vector4[] globalArray = new Vector4[ArrayLen];

    private Material _material;
    

    private void Awake()
    {
        var rend = GetComponent<MeshRenderer>();
        if (rend == null)
        {
            return;
        }

        _material = rend.material;
        
    }

    private void Update()
    {
        _material.SetVectorArray(CollidedObjects, globalArray);
    }
}
