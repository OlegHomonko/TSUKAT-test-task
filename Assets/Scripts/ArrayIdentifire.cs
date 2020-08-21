using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArrayIdentifire : MonoBehaviour
{
    private int arrayID = 0;
    [SerializeField] private AnimationCurve xDistanceYHeight;
    private static List<int> ArrayIdList = new List<int>();

    private Vector3 _hitPos = Vector3.zero;

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
        arrayID = GetEmptyArrayId();
    }

    private void OnDisable()
    {
        if (ArrayIdList.Contains(arrayID))
        {
            ArrayIdList.Remove(arrayID); 
        }

        arrayID = -1;
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
        if (arrayID == -1)
        {
            return;
        }

        var dis = Vector3.Distance(_hitPos, transform.position);
        var h = xDistanceYHeight.Evaluate(dis);

        var pos = transform.position;
        if (Physics.Raycast(transform.position, transform.forward, out RaycastHit hit))
        {
            pos = hit.point;
        }

        var v4 = new Vector4(pos.x, pos.y, pos.z, h);
        SetGlobalShaderArray.Instance.SetArrayVector(v4, arrayID);
    }

    private void FixedUpdate()
    {
        SetPositionToArray();
    }
}
