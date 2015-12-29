namespace Onvia.Glengarry.Search_Automation
{
    partial class SearchAutomation
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnProjectSearch = new System.Windows.Forms.Button();
            this.btnAgencySearch = new System.Windows.Forms.Button();
            this.btnSFCSearch = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.SearchAll = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnProjectSearch
            // 
            this.btnProjectSearch.Location = new System.Drawing.Point(6, 113);
            this.btnProjectSearch.Name = "btnProjectSearch";
            this.btnProjectSearch.Size = new System.Drawing.Size(140, 34);
            this.btnProjectSearch.TabIndex = 0;
            this.btnProjectSearch.Text = "Project Search";
            this.btnProjectSearch.UseVisualStyleBackColor = true;
            this.btnProjectSearch.Click += new System.EventHandler(this.ProjectSearch);
            // 
            // btnAgencySearch
            // 
            this.btnAgencySearch.Location = new System.Drawing.Point(6, 65);
            this.btnAgencySearch.Name = "btnAgencySearch";
            this.btnAgencySearch.Size = new System.Drawing.Size(140, 32);
            this.btnAgencySearch.TabIndex = 1;
            this.btnAgencySearch.Text = "Agency Search";
            this.btnAgencySearch.UseVisualStyleBackColor = true;
            this.btnAgencySearch.Click += new System.EventHandler(this.AgencySearch);
            // 
            // btnSFCSearch
            // 
            this.btnSFCSearch.Location = new System.Drawing.Point(152, 65);
            this.btnSFCSearch.Name = "btnSFCSearch";
            this.btnSFCSearch.Size = new System.Drawing.Size(132, 32);
            this.btnSFCSearch.TabIndex = 2;
            this.btnSFCSearch.Text = "SFC Search";
            this.btnSFCSearch.UseVisualStyleBackColor = true;
            this.btnSFCSearch.Click += new System.EventHandler(this.SFCSearch);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(6, 19);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(140, 30);
            this.button1.TabIndex = 3;
            this.button1.Text = "Load Saved Queries";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.SearchAll);
            this.groupBox1.Controls.Add(this.btnSFCSearch);
            this.groupBox1.Controls.Add(this.btnProjectSearch);
            this.groupBox1.Controls.Add(this.button1);
            this.groupBox1.Controls.Add(this.btnAgencySearch);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(292, 182);
            this.groupBox1.TabIndex = 4;
            this.groupBox1.TabStop = false;
            // 
            // SearchAll
            // 
            this.SearchAll.Location = new System.Drawing.Point(152, 113);
            this.SearchAll.Name = "SearchAll";
            this.SearchAll.Size = new System.Drawing.Size(131, 33);
            this.SearchAll.TabIndex = 4;
            this.SearchAll.Text = "All Search";
            this.SearchAll.UseVisualStyleBackColor = true;
            this.SearchAll.Click += new System.EventHandler(this.SearchAll_Click);
            // 
            // SearchAutomation
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(308, 239);
            this.Controls.Add(this.groupBox1);
            this.Name = "SearchAutomation";
            this.Text = "Search Automation";
            this.groupBox1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnProjectSearch;
        private System.Windows.Forms.Button btnAgencySearch;
        private System.Windows.Forms.Button btnSFCSearch;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button SearchAll;
    }
}

