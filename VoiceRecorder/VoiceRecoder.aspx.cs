using System;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Collections.Generic;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.Devices;

namespace VoiceRecorder
{
    public partial class VoiceRecoder : Page
    {
        [DllImport("winmm.dll", EntryPoint = "mciSendStringA")]
        private static extern int mciSendString(string lpstrCommand, string lpstrReturnString, int uReturnLength, int hwndCallback);

        // CHANGE THIS TO YOUR LOCAL FOLDER TO HOLD THE AUDIO FILES
        public string _baseLocation = "C:\\Users\\Mike\\Documents\\Hackathon\\Audio\\";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Computer computer = new Computer();
            // lstBoxEmployeeRecorded.Items.Clear();
            lblMessage.Visible = false;
            lblMessage.Text = string.Empty;
        }

        [WebMethod]
        public static string Upload(string name, string encodedBlob)
        {
          try {
            System.Diagnostics.Debug.WriteLine(DateTime.Now.ToString("yyyy-dd-MM HH:MM:ss ") + " | Received: " + encodedBlob);
        
            // To-do: Persist the base64 encoded audio blob

            return "name:" + name + ", encodedBlob:" + encodedBlob;
          }
          catch (Exception ex) { 
            System.Diagnostics.Debug.WriteLine(ex.Message);
            return ex.Message;
          }
        }

        /// <summary>
        /// Stop and Save Recording
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Btnsavestop_Click(object sender, EventArgs e)
        {
            try
            {
                lblMessage.Visible = false;
                string name = txtName.Text;
                if (!string.IsNullOrEmpty(name))
                {
                    name = name.Replace(" ", "_");
                    mciSendString($"save recsound {_baseLocation}{name}-Record.wav", "", 0, 0);
                    mciSendString("close recsound ", "", 0, 0);
                    Computer c = new Computer();
                    c.Audio.Stop();

                    //#region Show-Alert
                    //string message = "Voice Recorded and Saved !!";
                    //System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    //sb.Append("<script type = 'text/javascript'>");
                    //sb.Append("window.onload=function(){");
                    //sb.Append("alert('");
                    //sb.Append("message");
                    //sb.Append("')};");
                    //sb.Append("</script>");
                    //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
                    //#endregion Show-alert
                    lblMessage.Text = "Audio Saved !!";
                    lblMessage.Visible = true;
                }
                else
                {
                    Response.Write("Please enter employee name into the textbox to record");
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        /// <summary>
        /// Get all Recorded List
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button1_Click(object sender, EventArgs e)
        {
            lblMessage.Text = string.Empty;
            lstBoxEmployeeRecorded.Items.Clear();
            string[] allfiles = Directory.GetFiles(_baseLocation, "*.*", SearchOption.AllDirectories);
            StringBuilder sb = new StringBuilder();
            string[] files = Directory.GetFiles(_baseLocation);
            foreach (string file in files)
            {
                var fileNamewithextension = Path.GetFileName(file);
                string[] name = fileNamewithextension.Split('-');
                var actualName = name[0].Replace("_", " ");
                lstBoxEmployeeRecorded.Items.Add(actualName);
            }

            lbCount.Text = lstBoxEmployeeRecorded.Items.Count.ToString();
        }

        /// <summary>
        /// Start Recording
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            mciSendString("open new Type waveaudio Alias recsound", "", 0, 0);
            mciSendString("record recsound", "", 0, 0);
            lblMessage.Text = "Recording...";
            lblMessage.Visible = true;
        }

        /// <summary>
        /// Play the Audio
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(txtName.Text))
                {
                    Computer computer = new Computer();
                    string name = txtName.Text;
                    name = name.Replace(" ", "_");
                    computer.Audio.Play($"{_baseLocation}{name}-record.wav", AudioPlayMode.WaitToComplete);
                    //computer.Audio.Play($"{_baseLocation}{name}-record.wav");
                    computer.Audio.Stop();
                }
                else
                {
                    Response.Write("Please enter the employee name in txtbox");
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }


        /// <summary>
        /// Display all the recorded List.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lstBoxEmployeeRecorded_SelectedIndexChanged(object sender, EventArgs e)
        {
            var selectedvalue = lstBoxEmployeeRecorded.SelectedValue;
            string[] name = selectedvalue.Split('-');
            var actualName = name[0].Replace("_", " ");
            txtName.Text = actualName;
        }

    }
}