using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

public class ArrayIdentifire : MonoBehaviour
{
    [SerializeField] private float rayMaxDistance = 0.6f;
    [SerializeField] private AnimationCurve xDistanceYHeight;
    
    private static List<int> ArrayIdList = new List<int>();

    private Vector3 _hitPos = Vector3.zero;
    private int _arrayID = 0;

    private int GetEmptyArrayId()
    {
        if (ArrayIdList.Count >= SetGlobalShaderArray.ArrayLen)
        {
            return -1;
        }

        var res = -1;

        for (int i = 0; i < SetGlobalShaderArray.ArrayLen; i++)
        {
            if (ArrayIdList.Contains(i))
            {
                continue;
            }
            
            res = i;
            ArrayIdList.Add(res);
            break;
        }

        return res;
    }

    private void OnEnable()
    {
        _arrayID = GetEmptyArrayId();
    }

    private void OnDisable()
    {
        if (ArrayIdList.Contains(_arrayID))
        {
            ArrayIdList.Remove(_arrayID); 
        }

        _arrayID = -1;
    }

    private void OnTriggerStay(Collider other)
    {
        _hitPos = other.ClosestPointOnBounds(transform.position);
    }

    private void OnTriggerExit(Collider other)
    {
        _hitPos = Vector3.zero;
    }

    private void SetPositionToArray()
    {
        if (_arrayID == -1)
        {
            return;
        }

        var dis = Vector3.Distance(_hitPos, transform.position);
        var h = xDistanceYHeight.Evaluate(dis);

        var pos = transform.position;
        if (Physics.Raycast(transform.position, transform.forward, out RaycastHit hit, rayMaxDistance))
        {
            pos = hit.point;
        }

        var v4 = new Vector4(pos.x, pos.y, pos.z, h);
        SetGlobalShaderArray.Instance.SetArrayVector(v4, _arrayID);
    }

    private void FixedUpdate()
    {
        SetPositionToArray();
    }
}
