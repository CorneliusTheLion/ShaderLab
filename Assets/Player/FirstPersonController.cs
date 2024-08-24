using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;
using UnityEngine.InputSystem;
//using DG.Tweening;
using Cinemachine;

public class FirstPersonController : MonoBehaviour
{
    [SerializeField] private CharacterController cc;
    private FirstPersonInput playerInputActions;
    public bool IsGrounded { get; private set; }
    [SerializeField] private CinemachineVirtualCamera playerCamera;
    [SerializeField] private float ySensitivity = 1.0f;
    [SerializeField] private float xSensitivity = 1.0f;
    [SerializeField] private float maxLookAngle = 50f;
    [SerializeField] private float walkSpeed = 3f;
    private float yaw = 0.0f;
    private float pitch = 0.0f;

    private float currentGravityForce = 0f;
    [SerializeField] private float gravityForce = 9.8f;
    [SerializeField] private float jumpPower = 10f;

    private Vector3 newMove = Vector3.zero;
    private Vector2 _moveInput;
    private Vector2 _lookInput;

    private bool canMove = true;
    private bool canLook = true;

    // Start is called before the first frame update
    void Start()
    {
        InitializePlayerInput();
        Cursor.lockState = CursorLockMode.Locked;
    }

    void InitializePlayerInput()
    {
        playerInputActions = new FirstPersonInput();
        playerInputActions.Player.Enable();


    }

    // Update is called once per frame
    void Update()
    {
        GroundCheck();
        if(canLook)
            UpdateCamera();
        UpdateGravity();
        if(canMove)
            UpdateMovement();
        
    }

    void GroundCheck()
    {
        if (cc.isGrounded)
        {
            IsGrounded = true;
        }
        else
            IsGrounded = false;
    }

    void UpdateGravity()
    {
        if (!IsGrounded)
        {
            currentGravityForce = gravityForce;
        }
        else
            currentGravityForce = 0f;
    }

    void UpdateCamera()
    {
        _lookInput.x = playerInputActions.Player.MouseX.ReadValue<float>();
        _lookInput.y = playerInputActions.Player.MouseY.ReadValue<float>();

        pitch -= ySensitivity * _lookInput.y;   //non-inverted camera

        yaw = transform.localEulerAngles.y + _lookInput.x * xSensitivity;

        pitch = Mathf.Clamp(pitch, -maxLookAngle, maxLookAngle);

        playerCamera.transform.localEulerAngles = new Vector3(pitch, 0, 0);
        transform.localEulerAngles = new Vector3(0, yaw, 0);
    }

    void UpdateMovement()
    {
        _moveInput = playerInputActions.Player.Move.ReadValue<Vector2>();

        float newMoveY = newMove.y;

        //newMove.y = newMoveY;


        Vector3 forward = transform.TransformDirection(Vector3.forward);
        Vector3 right = transform.TransformDirection(Vector3.right);
        newMove = (forward * _moveInput.y * walkSpeed) + (right * _moveInput.x * walkSpeed);

        if (CanJump() && playerInputActions.Player.Jump.WasPressedThisFrame())
        {
            newMove.y = jumpPower;
            Jump();
        }
        else
        {
            newMove.y = newMoveY - currentGravityForce * Time.deltaTime;
        }

        cc.Move(newMove * Time.deltaTime);
    }


    private void Jump()
    {
        IsGrounded = false;
    }
    private bool CanJump()
    {
        if (IsGrounded) 
            return true;
        else
            return false;
    }

    public void ToggleMovement(bool enableMovement)
    {
        canMove = enableMovement;
    }
}
